from django.db.models import CharField
from django_filters import rest_framework as filters
from . import models

class CustomFilterBase(filters.FilterSet):
    """
    Extends Filterset to populate help_text from the associated model field.
    Works with swagger but not the builtin docs.
    """

    @classmethod
    def filter_for_field(cls, f, name, lookup_expr):
        result = super().filter_for_field(f, name, lookup_expr)

        if 'help_text' not in result.extra:
            result.extra['help_text'] = f.help_text
        return result


class DefaultFilterMeta:
    """
    Defaults for:
     - enable filtering by all model fields except `id`
     - ignoring upper/lowercase when on CharFields
    """
    # Let us filter by all fields except id
    exclude = ('id',)
    # We prefer case insensitive matching on CharFields
    filter_overrides = {
        CharField: {
            'filter_class': filters.CharFilter,
            'extra': lambda f: {
                'lookup_expr': 'iexact',
            },
        },
    }


class OcrbFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        model = models.OCRB


class OcrbSummaryFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        fields = ('fiscal_year', 'service_area', 'bureau')
        model = models.OCRB


class KpmFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        model = models.KPM


class BudgetHistoryFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        model = models.BudgetHistory


class LookupCodeFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        model = models.LookupCode


class HistoryServiceAreaFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        fields = ('service_area_code', 'fiscal_year')
        model = models.BudgetHistory


class HistoryBureauFilter(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        fields = ('service_area_code', 'fiscal_year', 'bureau_code', 'bureau_name')
        model = models.BudgetHistory


class HistoryObjectCode(CustomFilterBase):
    class Meta(DefaultFilterMeta):
        fields = ('fiscal_year', 'service_area_code', 'object_code')
        model = models.BudgetHistory