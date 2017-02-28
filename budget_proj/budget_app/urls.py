from django.conf.urls import url
from . import views


# Listed in alphabetical order.
urlpatterns = [
    url(r'^kpm/$', views.ListKpm.as_view()),
    url(r'^ocrb/$', views.ListOcrb.as_view()),
    url(r'^summary/', views.FindOperatingAndCapitalRequirements.as_view()),
]