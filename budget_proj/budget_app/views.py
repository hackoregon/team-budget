# include for aggregation
from django.db.models import Sum

# ------------------------------------------
# imports needed for the functional view
from rest_framework.response import Response
# ------------------------------------------

# ------------------------------------------
# generics class to make writing endpoints easier
from rest_framework import generics

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
        return models.OCRB.objects.order_by('-fiscal_year', 'budget_type', 'service_area', 'bureau', 'budget_category')



class OcrbSummary(generics.ListAPIView):
    """
    Summarize Budget for Operating and Capital Requirements by Service Area and Bureau
    """
    serializer_class = serializers.OcrbSumSerializer
    filter_class = filters.OcrbSummaryFilter

    def get_queryset(self):
        return models.OCRB.objects.values('fiscal_year', 'service_area', 'bureau')\
               .annotate(bureau_total=Sum('amount'))\
               .order_by('fiscal_year', 'service_area', 'bureau')



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
    filter_class = filters.HistoryBureauFilter

    def get_queryset(self):
        qs = models.BudgetHistory.objects.all()
        qs = qs.values('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name').annotate(amount=Sum('amount'))
        qs = qs.order_by('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name')
        return qs



class HistorySummaryByServiceArea(generics.ListAPIView):
    """
    Summary of BudgetHistory by Service Area.
    """
    serializer_class = serializers.HistorySummaryByServiceAreaSerializer
    filter_class = filters.HistoryServiceAreaFilter


    def get_queryset(self):
        qs = models.BudgetHistory.objects.all()
        qs = qs.values('fiscal_year', 'service_area_code', 'bureau_code').annotate(amount=Sum('amount'))
        qs = qs.order_by('fiscal_year', 'service_area_code')
        return qs



class HistorySummaryByServiceAreaObjectCode(generics.ListAPIView):
    """
    Summary of Historical Operating and Capital Requirements by Service Area and Object Code
    """
    serializer_class = serializers.HistorySummaryByServiceAreaObjectCodeSerializer
    filter_class = filters.HistoryObjectCode

    def get_queryset(self):
        qs = models.BudgetHistory.objects.all()
        qs = qs.values('fiscal_year', 'service_area_code', 'object_code').annotate(amount=Sum('amount'))
        qs = qs.order_by('fiscal_year', 'service_area_code', 'object_code')
        return qs



class ListLookupCode(generics.ListAPIView):
    """
    Code reference table for Budget History.
    Note: Parameter values are compared case-insensitive.
    """
    serializer_class = serializers.LookupCodeSerializer
    filter_class = filters.LookupCodeFilter


    def get_queryset(self):
        return models.LookupCode.objects.all()