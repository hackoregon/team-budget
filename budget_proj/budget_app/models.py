from django.db import models


class OCRB(models.Model):
    id = models.AutoField(primary_key=True)
    amount = models.IntegerField(blank=True, null=True)
    amount.help_text = 'Integer dollar amount.'
    bureau = models.CharField(db_index=True, max_length=255, default='')
    budget_category = models.CharField(db_index=True, max_length=255, default='')
    budget_category.help_text = 'General category for this amount, which is one of [Capital, Operating].'
    budget_type = models.CharField(db_index=True, max_length=255, default='')
    budget_type.help_text = 'Status of an item within the budget lifecycle: [Adopted, Revised, Actual].'
    fy = models.CharField(db_index=True, max_length=255, default='')
    fy.help_text = 'Fiscal Year as a string, e.g. 2015-16'
    service_area = models.CharField(db_index=True, max_length=255, default='')
    service_area.help_text = 'Name of a Service Area, which is a grouping of related Bureaus.'
    source_document = models.CharField(max_length=255, default='')
    source_document.help_text = 'Reference to publicly available document from which this data was extracted.'


class KPM(models.Model):
    id = models.AutoField(primary_key=True)
    amount = models.FloatField(blank=True, null=True)
    budget_type = models.CharField(max_length=255, default='')
    bureau = models.CharField(max_length=255, default='')
    fy = models.CharField(db_index=True, max_length=255, default='', help_text='Fiscal year (i.e. 2015-16)')
    key_performance_measures = models.CharField(max_length=255, default='')
    service_area = models.CharField(max_length=255, default='')
    source_document = models.CharField(max_length=255, default='')
    units = models.CharField(max_length=255, default='')


class LookupCode(models.Model):
    id = models.AutoField(primary_key=True)
    code = models.CharField(db_index=True, max_length=32, default='')
    code_type = models.CharField(db_index=True, max_length=32, default='')
    description = models.CharField(db_index=True, max_length=255, default='')


class BudgetHistory(models.Model):
    id = models.AutoField(primary_key=True)
    accounting_object_name = models.CharField(db_index=True, max_length=255, default='')
    accounting_object_name.help_text = 'Full name of a general accounting category corresponding to an object_code, such as "Internal Material and Services".'
    amount = models.IntegerField(blank=True, null=True)
    amount.help_text = 'Dollar amount as an integer, including 0. May be positive or negative.'
    bureau_code = models.CharField(db_index=True, max_length=32, default='')
    bureau_code.help_text = '2-character ID for a Bureau, e.g. "PS" for Public Safety.'
    bureau_name = models.CharField(db_index=True, max_length=255, default='')
    division_code = models.CharField(max_length=32, default='')
    fiscal_year = models.CharField(db_index=True, max_length=32, default='')
    fiscal_year.help_text = 'Fiscal Year as a string, e.g. 2015-16.'
    functional_area_code = models.CharField(max_length=32, default='')
    functional_area_code.help_text = 'String ID for a functional area within a bureau, e.g. "PRREAQ" for Aquatics.'
    functional_area_name = models.CharField(db_index=True, max_length=255, default='')
    functional_area_name.help_text = 'Name for a functional area corresponding to a functional_area_code within a bureau, e.g. "Aquatics".'
    fund_center = models.CharField(max_length=32, default='')
    fund_center_code = models.CharField(max_length=32, default='')
    fund_center_code.help_text = 'String ID for a source of funds, e.g. "PKPR000025" for Aquatics Program Admin.'
    fund_center_name = models.CharField(max_length=255, default='')
    fund_center_name.help_text = 'Name corresponding to a fund_center_code, e.g. "Systems Development Charges".'
    fund_code = models.CharField(max_length=32, default='')
    fund_code.help_text = 'String ID [CAPITAL, DEBT_SVC, ENTERPRISE, GENERAL, INT_SVC, PERM, SPEC_REV, TRUST_PEN].'
    fund_name = models.CharField(max_length=255, default='')
    fund_name.help_text = 'Name of a source of funds corresponding to a fund_code, e.g. "Capital Projects"'
    object_code = models.CharField(db_index=True, max_length=32, default='')
    object_code.help_text = 'Short string ID for a general accounting category, e.g. "EMS" for External Material and Services or "CAPITAL" for Capital Expenditures.'
    program_code = models.CharField(max_length=32, default='')
    service_area_code = models.CharField(db_index=True, max_length=32, default='')
    service_area_code.help_text = '2-character ID [CD, LA, PR, PS, PU, TP] for a Service Area, which is a grouping of related Bureaus.'
    sub_program_code = models.CharField(max_length=32, default='')
