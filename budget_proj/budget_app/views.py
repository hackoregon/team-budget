import csv, os
from django.conf import settings

# ------------------------------------------
# imports needed for the functional view
from rest_framework.decorators import api_view
from rest_framework.response import Response
# ------------------------------------------

# ------------------------------------------
# generics class to make writing endpoints easier
from rest_framework import generics
# ------------------------------------------

# ------------------------------------------
# main pieces from our DRF app that need to be linked
from . import models
from . import serializers
# ------------------------------------------


def find_ocrb_data():
    """
    helper method to read and parse ocrb csv data.
    To be used until we get data loaded into our models
    """
    fname = 'Budget_in_Brief_OCRB_data_All_Years.csv'
    f = open(os.path.join(settings.BASE_DATA_DIR, fname), 'r')
    col_headers = ['source_document', 'service_area', 'bureau', 'budget_category', 'amount', 'fy', 'budget_type']
    reader = csv.DictReader(f, col_headers)
    next(reader) # skip column headers
    all_objects = [models.OCRB(**row) for row in reader]
    return all_objects


def find_kpm_data():
    """
    helper method to read and parse kpm csv data.
    To be used until we get data loaded into our models
    """
    fname = 'Budget_in_Brief_KPM_data_All_Years.csv'
    f = open(os.path.join(settings.BASE_DATA_DIR, fname), 'r')
    col_headers = ['source_document', 'service_area', 'bureau', 'key_performance_measures', 'fy', 'budget_type', 'amount',
        'units']
    reader = csv.DictReader(f, col_headers)
    next(reader) # skip column headers
    all_objects = [models.KPM(**row) for row in reader]
    for obj in all_objects: # remove empty strings from number fields, fix in serializer?
        if obj.amount == '':
            obj.amount = None
    return all_objects


class ListOcrb(generics.ListAPIView):
    """
    A class based view that inherits from the generics class. The generics
    class gives you a convenient way to declare views quickly when you only
    need basic functionality or simple CRUD operations.
    """
    queryset = find_ocrb_data()
    serializer_class = serializers.OcrbSerializer

class OcrbList(generics.ListCreateAPIView):
    """
    Class based view that inherits from the generics class and pulls from AWS
    """
    queryset = models.OCRB.objects.all()
    serializer_class = serializers.OcrbSerializer
    def get(self, request, *args, **kwargs):
        #check for query params
        #eg: http://127.0.0.1:8000/ocrb-prod/?amount=0
        k = request.GET.keys()
        filter_dict = {}
        if(k):
            for key, value in request.GET.items():
                filter_dict[key] = value
            ocrbs = models.OCRB.objects.filter(**filter_dict)
            serialized_data = serializers.OcrbSerializer(ocrbs, many=True)
            return Response(serialized_data.data)
        else:
            serialized_data = serializers.OcrbSerializer(models.OCRB.objects.all(), many=True)
            return Response(serialized_data.data)


class ListKpm(generics.ListAPIView):
    """
    A class based view that inherits from the generics class as well.
    """
    queryset = find_kpm_data()
    serializer_class = serializers.KpmSerializer

class KpmList(generics.ListCreateAPIView):
    """
    Class based view that inherits from the generics class and pulls from AWS
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer

class FindOperatingAndCapitalRequirements(generics.ListAPIView):
    """
    Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.

    No more than one instance of each parameter may be given. For example,
    To see all records for all service areas:
    >>> /summary
    To see only records for bureaus in the 'Community Development' service_area:
    >>> /summary?service_area=Community Development
    To see only records for fiscal year '2015-16' for the bureaus in the 'Community Development' service_area:
    >>> /summary?fy=2015-16&service_area=Community Development
    To see only 'Adopted' budget figures for the 'Portland Parks & Recreation' bureau (Note: the '&' embedded in the bureau name must be URI encoded as '%26'):
    >>> /summary?budget_type=Adopted&bureau=Portland Parks %26 Recreation
    If there are no matches for the query parameters, an empty list is returned. For example,
    >>> /summary?fy=1776-77
    This usually means that you spelled one of the parameter names wrong or you gave an unknown value for the parameter. However, the service still returns an HTTP 200 OK response, because an empty list is a valid response.
    Note: Parameter names and parameter values are not case-sensitive.

    :parameter fy: fiscal year (optional) formatted as nnnn-nn, e.g. 2015-16.
    """
    # Assumption: the Model gets data from the database.
    # This enables us to use Model attributes, like 'objects',
    # and a QuerySet, which enables use of 'filter' and 'order_by'.

    serializer_class = serializers.OcrbSerializer

    def get_queryset(self):
        """
        Filters the objects based on query parameters.
        :return: Subset of all OCRB objects that matches the conjunction of all non-null query parameters.
        """
        # TODO: There must be a better way to conjoin all these filters
        # while still handling the None case correctly.
        # This code looks really klunky. (I wrote it, so it is okay for me to say that.)
        queryset = models.OCRB.objects.all()
        fiscal_year = self.request.query_params.get('fy', None)
        if fiscal_year is not None:
            queryset = queryset.filter(fy__iexact=fiscal_year)
        service_area = self.request.query_params.get('service_area', None)
        if service_area is not None:
            queryset = queryset.filter(service_area__iexact=service_area)
        bureau = self.request.query_params.get('bureau', None)
        if bureau is not None:
            queryset = queryset.filter(bureau__iexact=bureau)
        budget_type = self.request.query_params.get('budget_type', None)
        if budget_type is not None:
            queryset = queryset.filter(budget_type__iexact=budget_type)
        budget_category = self.request.query_params.get('budget_category', None)
        if budget_category is not None:
            queryset = queryset.filter(budget_category__iexact=budget_category)
        return queryset.order_by('fy', 'budget_type', 'service_area', 'bureau', 'budget_category')
