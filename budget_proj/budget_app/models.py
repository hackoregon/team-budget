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
    amount = models.FloatField(blank=True, null=True)
    units = models.CharField(max_length=255, default='')

class LookupCode(models.Model):
    id = models.AutoField(primary_key=True)
    code_type = models.CharField(max_length=32, default='')
    code = models.CharField(max_length=32, default='')
    description = models.CharField(max_length=255, default='')

class BudgetHistory(models.Model):
    id = models.AutoField(primary_key=True)
    fund_center_code = models.CharField(max_length=32, default='')
    fund_code = models.CharField(max_length=32, default='')
    functional_area_code = models.CharField(max_length=32, default='')
    object_code = models.CharField(max_length=32, default='')
    fund_center_name = models.CharField(max_length=255, default='')
    fund_name = models.CharField(max_length=255, default='')
    functional_area_name = models.CharField(max_length=255, default='')
    accounting_object_name = models.CharField(max_length=255, default='')
    service_area_code = models.CharField(max_length=32, default='')
    service_area = models.ForeignKey(LookupCode)
    program_code = models.CharField(max_length=32, default='')
    sub_program_code = models.CharField(max_length=32, default='')
    fund_center = models.CharField(max_length=32, default='')
    division_code = models.CharField(max_length=32, default='')
    bureau_code = models.CharField(max_length=32, default='')
    bureau_name = models.CharField(max_length=255, default='')
    fiscal_year = models.CharField(max_length=32, default='')
    amount = models.IntegerField(blank=True, null=True)
