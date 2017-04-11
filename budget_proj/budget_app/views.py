from django.views.decorators.http import require_http_methods

# ------------------------------------------
# imports needed for the functional view
from rest_framework.response import Response
# ------------------------------------------

# ------------------------------------------
# generics class to make writing endpoints easier
from rest_framework import generics
# ------------------------------------------

# include for aggregation
from django.db.models import Sum, Count

# ------------------------------------------
# main pieces from our DRF app that need to be linked
from . import models
from . import serializers
from . import filters
# ------------------------------------------

class ListOcrb(generics.ListAPIView):
    """
    Operating and Capital Requirements by Bureau (OCRB).
    Note: Parameter values are compared case-insensitive.
    """
    serializer_class = serializers.OcrbSerializer
    filter_class = filters.OcrbFilter

    def get_queryset(self):
        return models.OCRB.objects.order_by('-fy', 'budget_type', 'service_area', 'bureau', 'budget_category')



class OcrbSummary(generics.ListAPIView):
    """
    Summarize Budget for Operating and Capital Requirements by Service Area and Bureau
    """
    serializer_class = serializers.OcrbSumSerializer

    def get_queryset(self):
        return models.OCRB.objects.all()

    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.
        Note: Parameter names and parameter values are compared case-insensitive.
        """

        if request.GET.keys():
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower() + "__iexact"] = value  # Assumes all model attributes are lowercase.
            ocrbs = models.OCRB.objects.filter(**filter_dict)
        else:
            ocrbs = self.get_queryset()
        grouped_ocrbs = ocrbs.values('fy','service_area', 'bureau').annotate(bureau_total=Sum('amount'))
        sorted_ocrbs = grouped_ocrbs.order_by('fy','service_area','bureau')
        serialized_data = self.serializer_class(sorted_ocrbs, many=True)
        return Response(serialized_data.data)


class ListKpm(generics.ListAPIView):
    """
    Key Performance Measures (KPM).
    Note: Parameter values are compared case-insensitive.
    """
    queryset = models.KPM.objects.all()
    serializer_class = serializers.KpmSerializer
    filter_class = filters.KpmFilter


class ListBudgetHistory(generics.ListAPIView):
    """
    Historical Operating and Capital Requirements by Service Area and Bureau
    Note: Parameter values are compared case-insensitive.
    """
    serializer_class = serializers.BudgetHistorySerializer
    filter_class = filters.BudgetHistoryFilter


    def get_queryset(self):
        return models.BudgetHistory.objects.order_by('fiscal_year', 'bureau_name', 'accounting_object_name', 'functional_area_name')



class HistorySummaryByBureau(generics.ListAPIView):
    """
    Summary of Historical Operating and Capital Requirements by Service Area and Bureau
    """
    serializer_class = serializers.HistorySummaryBureauSerializer

    def get_queryset(self):
        return models.BudgetHistory.objects.all()

    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.
        Note: Parameter names and parameter values are compared case-insensitive.
        """
        if request.GET.keys():
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower() + "__iexact"] = value  # Assumes all model attributes are lowercase.
            rows = models.BudgetHistory.objects.filter(**filter_dict)
        else:
            rows = self.get_queryset()
        grouped_rows = rows.values('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name').annotate(amount=Sum('amount'))
        sorted_rows = grouped_rows.order_by('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name')
        serialized_data = self.serializer_class(sorted_rows, many=True)
        return Response(serialized_data.data)


class HistorySummaryByServiceArea(generics.ListAPIView):
    """
    Summary of BudgetHistory by Service Area.
    """
    serializer_class = serializers.HistorySummaryByServiceAreaSerializer

    def get_queryset(self):
        return models.BudgetHistory.objects.all()

    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Bureau.
        Note: Parameter names and parameter values are compared case-insensitive.
        """
        if request.GET.keys():
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower() + "__iexact"] = value  # Assumes all model attributes are lowercase.
            rows = models.BudgetHistory.objects.filter(**filter_dict)
        else:
            rows = self.get_queryset()
        grouped_rows = rows.values('fiscal_year', 'service_area_code').annotate(amount=Sum('amount'))
        sorted_rows = grouped_rows.order_by('fiscal_year', 'service_area_code')
        serialized_data = self.serializer_class(sorted_rows, many=True)
        return Response(serialized_data.data)


class HistorySummaryByServiceAreaObjCode(generics.ListAPIView):
    """
    Summary of Historical Operating and Capital Requirements by Service Area and Object Code
    """
    serializer_class = serializers.HistorySummaryByServiceAreaObjectCodeSerializer

    def get_queryset(self):
        return models.BudgetHistory.objects.all()

    def get(self, request, *args, **kwargs):
        """
        Uses query parameters to select items to be returned from the database that summarizes Operating and Capital Requirements by Service Area and Object Code.
        Note: Parameter names and parameter values are compared case-insensitive.
        """
        if request.GET.keys():
            # Build a dictionary of query parameters and their values.
            filter_dict = {}
            for key, value in request.GET.items():
                filter_dict[key.lower() + "__iexact"] = value  # Assumes all model attributes are lowercase.
            rows = models.BudgetHistory.objects.filter(**filter_dict)
        else:
            rows = self.get_queryset()
        grouped_rows = rows.values('fiscal_year','service_area_code', 'object_code').annotate(amount=Sum('amount'))
        sorted_rows = grouped_rows.order_by('fiscal_year','service_area_code','object_code')
        serialized_data = self.serializer_class(sorted_rows, many=True)
        return Response(serialized_data.data)


class ListLookupCode(generics.ListAPIView):
    """
    Code reference table for Budget History.
    Note: Parameter values are compared case-insensitive.
    """
    serializer_class = serializers.LookupCodeSerializer
    filter_class = filters.LookupCodeFilter


    def get_queryset(self):
        return models.LookupCode.objects.all()