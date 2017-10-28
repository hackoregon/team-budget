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
        fields = ('fiscal_year', 'service_area', 'bureau', 'bureau_total',)


class KpmSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.KPM
        exclude = ('id',)


class BudgetHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BudgetHistory
        exclude = ('id',)


class HistorySummaryBureauSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    sa_calced = serializers.CharField()

    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name', 'sa_calced', 'amount',)


class HistorySummaryByServiceAreaSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    sa_calced = serializers.CharField()

    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_code', 'bureau_code', 'sa_calced', 'amount')


class HistorySummaryByServiceAreaObjectCodeSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_code', 'object_code', 'amount',)


class LookupCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LookupCode
        exclude = ('id',)
