from rest_framework import serializers
from . import models


class OcrbSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OCRB
        fields = '__all__'

class KpmSerializer(serializers.ModelSerializer):
	class Meta:
		model = models.KPM
		fields = '__all__'