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


# @api_view(['GET'])
# def ocrb(request):
#     """
#     A function based view that uses the api_view decorator to add functionality
#     to the view.
#     """
#     if request.method == 'GET':
#         ocrb_all_bureaus = models.Ocrb.objects.all()
#         serializer = serializers.OcrbSerializer(ocrb, many=True)
#         return Response(serializer.data)

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
    fname = 'Budget_in%20_Brief_KPM_data_All_Years.csv'
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
    class gives you a convinient way to declare views quickly when you only
    need basic functionality or simple CRUD operations.
    """
    queryset = find_ocrb_data()
    serializer_class = serializers.OcrbSerializer

class ListKpm(generics.ListAPIView):
    """
    A class based view that inherits from the movies class
    """
    queryset = find_kpm_data()
    serializer_class = serializers.KpmSerializer
