import csv

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


def getAllOcrb():
    """
    Brute force implementation re-loads from CSV every time that data is needed.
    The CSV is assumed to have a header row of column names, which is ignored.
    :return: All OCRB objects defined in the CSV.
    """
    f = '../Data/Budget_in_Brief_OCRB_data_All_Years.csv'
    col_headers = ['source_document', 'service_area', 'bureau', 'budget_category', 'amount', 'fy', 'budget_type']
    reader = csv.DictReader(open(f, 'r'), col_headers)
    all_data = [obj for obj in reader]

    # skip header row
    all_data = all_data[1:]
    all_obj = [models.OCRB(**data) for data in all_data]
    return all_obj

class ListOcrb(generics.ListAPIView):
    # queryset is required by superclass, even though we do not use it here.
    queryset = models.OCRB.objects.all()

    def get(self, request, format=None):
        return Response(serializers.OcrbSerializer(getAllOcrb(), many=True).data)


class FindOperatingAndCapitalRequirements(generics.ListAPIView):
    """
    Uses query parameters to select items to be returned.
    Assumption: the Model gets data from the database.
    This enables us to use Model attributes, like 'objects',
    and a QuerySet, which enables use of 'filter' and 'order_by'.
    """
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
            queryset = queryset.filter(fy__exact=fiscal_year)
        service_area = self.request.query_params.get('service_area', None)
        if service_area is not None:
            queryset = queryset.filter(service_area__exact=service_area)
        bureau = self.request.query_params.get('bureau', None)
        if bureau is not None:
            queryset = queryset.filter(bureau__exact=bureau)
        budget_type = self.request.query_params.get('budget_type', None)
        if budget_type is not None:
            queryset = queryset.filter(budget_type__exact=budget_type)
        budget_category = self.request.query_params.get('budget_category', None)
        if budget_category is not None:
            queryset = queryset.filter(budget_category__exact=budget_category)
        return queryset.order_by('fy', 'budget_type', 'service_area', 'bureau', 'budget_category')


class ListKpm(generics.ListAPIView):
    """
    A class based view that inherits from the ListAPIView class,
    but overrides the 'get' method to load data without using the database.
    """
    # queryset is required by superclass, even though we do not use it here.
    queryset = models.KPM.objects.all()

    def get(self, request, format=None):
        f = '../Data/Budget_in _Brief_KPM_data_All_Years.csv'
        col_headers = ['source_document', 'service_area', 'bureau', 'key_performance_measures', 'fy', 'budget_type', 'amount',
        'units']
        reader = csv.DictReader(open(f, 'r'), col_headers)
        all_data = [obj for obj in reader]

        # skip header row
        all_data = all_data[1:]
        all_obj = [models.KPM(**data) for data in all_data]
        for obj in all_obj: # remove empty strings from number fields
            if obj.amount == '':
                obj.amount = None

        serializer = serializers.KpmSerializer(all_obj, many=True)

        return Response(serializer.data)