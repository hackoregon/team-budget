from django.conf.urls import url
from . import views
from rest_framework_swagger.views import get_swagger_view

schema_view = get_swagger_view(title='hackoregon_budget')

# Listed in alphabetical order.
urlpatterns = [
    url(r'^$', schema_view),
    url(r'^code/$', views.ListLookupCode.as_view(), name='code-list'),
    url(r'^history/$', views.ListBudgetHistory.as_view(), name='history-list'),
    url(r'^history/service_area/$', views.HistorySummaryByServiceArea.as_view(), name='history-service-area'),
    url(r'^history/summary/$', views.HistorySummaryByBureau.as_view(), name='history-summary'),
    url(r'^history/sa/objcode/$', views.HistorySummaryByServiceAreaObjCode.as_view(), name='history-sa-objcode-summary'),
    url(r'^kpm/$', views.ListKpm.as_view(), name='kpm-list'),
    url(r'^ocrb/$', views.ListOcrb.as_view(), name='ocrb-list'),
    url(r'^ocrb/summary/$', views.OcrbSummary.as_view(), name='ocrb-summary'),
]