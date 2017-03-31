"""example_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.conf import settings
# This import is necessary to enable Swagger styling to work when the app runs in Docker container
from django.contrib.staticfiles.urls import staticfiles_urlpatterns

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^budget/', include('budget_app.urls', namespace='budget_app')),
]

# This statement is necessary to enable Swagger styling to work when the app runs in Docker container
urlpatterns += staticfiles_urlpatterns()

# This part is for detecting and running django debug toolbar
if settings.DEBUG:
    try:
        import debug_toolbar
        urlpatterns = [url(r'^__debug__/', include(debug_toolbar.urls)),] + urlpatterns
    except ImportError:
        pass