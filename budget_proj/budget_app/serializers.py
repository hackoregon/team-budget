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
    service_area_total = serializers.IntegerField()
    service_area_name = serializers.ReadOnlyField(source='service_area.description')
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year','service_area_code', 'service_area_name', 'service_area_total')

class LookupCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LookupCode
        exclude = ('id',)

