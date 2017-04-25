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
        fields = ('fy', 'service_area', 'bureau', 'bureau_total',)


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
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_code', 'bureau_code', 'bureau_name', 'amount',)


class HistorySummaryByServiceAreaSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    service_area_calc = serializers.SerializerMethodField()

    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_calc',  'amount')

    def get_service_area_calc(self, history):
        "Returns the calculated service area."
        eo_list = ['MY', 'PA', 'PS', 'PW', 'PU', 'AU']
        if history['bureau_code'] == 'MF':
            aResult = 'LA'
        elif history['bureau_code'] in eo_list:
            aResult = 'EO'
        else:
            aResult = history['service_area_code']
        return aResult

class HistorySummaryByServiceAreaObjectCodeSerializer(serializers.ModelSerializer):
    amount = serializers.IntegerField()
    class Meta:
        model = models.BudgetHistory
        fields = ('fiscal_year', 'service_area_code', 'object_code', 'amount',)


class LookupCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LookupCode
        exclude = ('id',)
