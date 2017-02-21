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


class ListOcrb(generics.ListAPIView):
    """
    A class based view that inherits from the generics class. The generics
    class gives you a convinient way to declare views quickly when you only
    need basic functionality or simple CRUD operations.
    """
    queryset = models.OCRB.objects.all()
    serializer_class = serializers.OcrbSerializer


    def get(self, request, format=None):
        f = '../Data/Budget_in_Brief_OCRB_data_All_Years.csv'
        col_headers = ['source_document', 'service_area', 'bureau', 'budget_category', 'amount', 'fy', 'budget_type']
        reader = csv.DictReader(open(f, 'r'), col_headers)
        all_data = [obj for obj in reader]

        # skip header row
        all_data = all_data[1:]
        all_obj = [models.OCRB(**data) for data in all_data]
        serializer = serializers.OcrbSerializer(all_obj, many=True)

        return Response(serializer.data)


class ListKpm(generics.ListAPIView):
    """
    A class based view that inherits from the movies class
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer

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