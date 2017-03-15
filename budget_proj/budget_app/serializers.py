from rest_framework import serializers
from . import models


class OcrbSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OCRB
        exclude = ('id',)


class KpmSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.KPM
        exclude = ('id',)


class BudgetHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BudgetHistory
        exclude = ('id',)


