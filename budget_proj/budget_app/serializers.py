from rest_framework import serializers
from . import models


class OcrbSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OCRB
        exclude = ('id',)


class OcrbSumSerializer(serializers.ModelSerializer):
    bureau_total = serializers.IntegerField()
    class Meta:
        model = models.OCRB
        fields = ('fy','service_area', 'bureau','bureau_total',)


class KpmSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.KPM
        exclude = ('id',)


class BudgetHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BudgetHistory
        exclude = ('id',)


class HistorySummaryBureauSerializer(serializers.ModelSerializer):
    bureau_total = serializers.IntegerField()
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year','service_area_code', 'bureau_name','bureau_total',)


class HistorySummaryByServiceAreaSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year','service_area_code', 'amount')


class HistorySummaryByServiceAreaObjCodeSerializer(serializers.ModelSerializer):
    object_total = serializers.IntegerField()
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year','service_area_code', 'object_code','object_total',)


class LookupCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LookupCode
        exclude = ('id',)
