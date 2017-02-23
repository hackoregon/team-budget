from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^ocrb/$', views.ListOcrb.as_view()),
    url(r'^kpm/$', views.ListKpm.as_view()),
    url(r'^budget/', views.FindOperatingAndCapitalRequirements.as_view()),
]