from django.db import models

class OCRB(models.Model):
    id = models.AutoField(primary_key=True)
    source_document = models.CharField(max_length=255, default='')
    service_area = models.CharField(max_length=255, default='')
    bureau = models.CharField(max_length=255, default='')
    budget_category = models.CharField(max_length=255, default='')
    amount = models.IntegerField(blank=True, null=True)
    fy = models.CharField(max_length=255, default='')
    budget_type = models.CharField(max_length=255, default='')



class KPM(models.Model):
    id = models.AutoField(primary_key=True)
    source_document = models.CharField(max_length=255, default='')
    service_area = models.CharField(max_length=255, default='')
    bureau = models.CharField(max_length=255, default='')
    key_performance_measures = models.CharField(max_length=255, default='')
    fy = models.CharField(max_length=255, default='')
    budget_type = models.CharField(max_length=255, default='')
    amount = models.IntegerField(blank=True, null=True)
    units = budget_type = models.CharField(max_length=255, default='')