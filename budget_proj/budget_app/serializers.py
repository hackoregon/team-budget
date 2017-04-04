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
        fields = ('service_area', 'bureau','bureau_total',)

class KpmSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.KPM
        exclude = ('id',)


class BudgetHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BudgetHistory
        exclude = ('id',)

class LookupCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LookupCode
        exclude = ('id',)

