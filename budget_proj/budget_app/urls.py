from django.conf.urls import url
from . import views
from rest_framework_swagger.views import get_swagger_view

schema_view = get_swagger_view(title='hackoregon_budget')

# Listed in alphabetical order.
urlpatterns = [
    url(r'^$', schema_view),
    url(r'^code/$', views.ListLookupCode.as_view(), name='code-list'),
    url(r'^history/$', views.ListBudgetHistory.as_view(), name='history-list'),
    url(r'^kpm/$', views.ListKpm.as_view(), name='kpm-list'),
    url(r'^ocrb/$', views.ListOcrb.as_view(), name='ocrb-list'),
    url(r'^ocrbsummary/$', views.OcrbSummary.as_view(), name='ocrb-summary'),
]