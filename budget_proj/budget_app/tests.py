import json # enables inspecting JSON data for certain fields
from django.test import TestCase, Client
# NOTE: disabled these for now but expect they'll be used in the near future
# from django.urls import reverse
# from budget_app.models import OCRB
# from mixer.backend.django import mixer
# from rest_framework import status
# from rest_framework.test import APITestCase

# Other Ideas:
# - http://stackoverflow.com/questions/24904362/how-to-write-unit-tests-for-django-rest-framework-apis
# - https://github.com/hackoregon/hacku-devops-2017/wiki/Assignment-5
# - http://www.django-rest-framework.org/api-guide/testing/

class TestCodeEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/code/')

        self.assertEqual(response.status_code, 200)

    def test_code_get_request_works_with_query_param(self):
        response = self.client.get("/budget/code/?code=AT")
        self.assertEqual(response.status_code, 200)
        json_content = json.loads(response.content.decode('utf-8'))
        codes = [item["code"] for item in json_content]

        for code in codes:
            self.assertEqual(code, 'AT')

class TestHistoryEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/history/')

        self.assertEqual(response.status_code, 200)

    def test_history_get_request_works_with_query_param(self):
        response = self.client.get("/budget/history/?fiscal_year=2015-16&bureau_code=PS")
        self.assertEqual(response.status_code, 200)
        json_content = json.loads(response.content.decode('utf-8'))
        fiscal_years = [item["fiscal_year"] for item in json_content]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')

class TestKpmEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/kpm/')

        self.assertEqual(response.status_code, 200)

    def test_kpm_get_request_works_with_query_param(self):
        response = self.client.get("/budget/kpm/?fy=2015-16")
        self.assertEqual(response.status_code, 200)
        json_content = json.loads(response.content.decode('utf-8'))
        results = json_content['results']
        fiscal_years = [item["fy"] for item in results]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')

class TestOcrbEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/budget/ocrb/')

        self.assertEqual(response.status_code, 200)

    def test_ocrb_get_request_works_with_query_param(self):
        response = self.client.get("/budget/ocrb/?fy=2015-16")
        self.assertEqual(response.status_code, 200)
        json_content = json.loads(response.content.decode('utf-8'))
        fiscal_years = [item["fy"] for item in json_content]
        results = json_content['results']
        fiscal_years = [item["fy"] for item in results]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')
