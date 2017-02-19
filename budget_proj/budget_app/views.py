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


class ListKpm(generics.ListAPIView):
    """
    A class based view that inherits from the movies class
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer




