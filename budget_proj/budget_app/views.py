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
    serializer_class = serializers.OcrbSerializer


    def get_queryset(self):
        return models.OCRB.objects.all()


    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.
        Note: Parameter names are case-insensitive, but parameter values are case-sensitive.
        """
        if(request.GET.keys()):
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower()] = value  # Assumes all model attributes are lowercase.
            # TODO: Make filtering be case-insensitive for parameter values.
            ocrbs = models.OCRB.objects.filter(**filter_dict)
        else:
            ocrbs = self.get_queryset()
        sorted_ocrbs = ocrbs.order_by('fy', 'budget_type', 'service_area', 'bureau', 'budget_category')
        serialized_data = self.serializer_class(sorted_ocrbs, many=True)
        return Response(serialized_data.data)


# TODO: Configure ListKpm so that GET and HEAD are the only possible HTTP actions.
class ListKpm(generics.ListCreateAPIView):
    """
    Key Performance Measures (KPM).
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer

