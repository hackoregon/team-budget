from django.views.decorators.http import require_http_methods

# ------------------------------------------
# imports needed for the functional view
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

# TODO: Configure ListOcrb so that GET and HEAD are the only possible HTTP actions.
class ListOcrb(generics.ListCreateAPIView):
    """
    Operating and Capital Requirements by Bureau (OCRB).
    """
    queryset = models.OCRB.objects.all()
    serializer_class = serializers.OcrbSerializer


    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.
        Note: Parameter names are case-insensitive, but parameter values are case-sensitive.
        """
        serialized_data = None
        if(request.GET.keys()):
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower()] = value
            # TODO: Make filtering by parameter values be case-insensitive.
            ocrbs = models.OCRB.objects.filter(**filter_dict)
        else:
            ocrbs = models.OCRB.objects.all()
        ocrbs = ocrbs.order_by('fy', 'budget_type', 'service_area', 'bureau', 'budget_category')
        serialized_data = serializers.OcrbSerializer(ocrbs, many=True)
        return Response(serialized_data.data)


# TODO: Configure ListKpm so that GET and HEAD are the only possible HTTP actions.
class ListKpm(generics.ListCreateAPIView):
    """
    Key Performance Measures (KPM).
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer

