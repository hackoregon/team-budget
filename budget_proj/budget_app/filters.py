from django.db.models import CharField
from django_filters import rest_framework as filters
from . import models


class DefaultFilterMeta:
    """
    Set our default Filter configurations to DRY up the FilterSet Meta classes.
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


class OcrbFilter(filters.FilterSet):
    class Meta(DefaultFilterMeta):
        model = models.OCRB


class KpmFilter(filters.FilterSet):
    class Meta(DefaultFilterMeta):
        model = models.KPM


class BudgetHistoryFilter(filters.FilterSet):
    class Meta(DefaultFilterMeta):
        model = models.BudgetHistory



class LookupCodeFilter(filters.FilterSet):
    class Meta(DefaultFilterMeta):
        model = models.LookupCode

