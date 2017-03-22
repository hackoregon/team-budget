from django.test import TestCase, Client
from django.urls import reverse
from budget_app.models import OCRB
from mixer.backend.django import mixer
from rest_framework import status
from rest_framework.test import APITestCase

# Ideas:
# - http://stackoverflow.com/questions/24904362/how-to-write-unit-tests-for-django-rest-framework-apis
# - https://github.com/hackoregon/hacku-devops-2017/wiki/Assignment-5
# - http://www.django-rest-framework.org/api-guide/testing/

class TestCodeEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/code/')

        self.assertEqual(response.status_code, 200)

class TestHistoryEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/history/')

        self.assertEqual(response.status_code, 200)

class TestKpmEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/kpm/')

        self.assertEqual(response.status_code, 200)

class TestOcrbEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/ocrb/')

        self.assertEqual(response.status_code, 200)
