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

    def test_ok(self):
        response = self.client.get('/budget/code/')

        self.assertEqual(response.status_code, 200)

    def test_code_get_request_works_with_query_param(self):
        response = self.client.get("/budget/code/", {'code': 'AT'})
        self.assertEqual(response.status_code, 200)
        json_content = response.json()
        code_data = json_content['results']
        codes = [item["code"] for item in code_data]

        for code in codes:
            self.assertEqual(code, 'AT')

    def test_code_response_is_paginated(self):
        response = self.client.get('/budget/code/')

        json = response.json()

        self.assertTrue('count' in json)
        self.assertTrue('next' in json)
        self.assertTrue('previous' in json)
        self.assertTrue('results' in json)


class TestHistoryEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test_ok(self):
        response = self.client.get('/budget/history/')

        self.assertEqual(response.status_code, 200)

    def test_history_get_request_works_with_query_param(self):
        query_params = {'fiscal_year': '2015-16', 'bureau_code': 'PS'}
        response = self.client.get("/budget/history/", query_params)

        self.assertEqual(response.status_code, 200)

        results = response.json()['results']
        fiscal_years = [item["fiscal_year"] for item in results]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')

    def test_history_response_is_paginated(self):
        response = self.client.get('/budget/history/')

        json = response.json()

        self.assertTrue('count' in json)
        self.assertTrue('next' in json)
        self.assertTrue('previous' in json)
        self.assertTrue('results' in json)


class TestKpmEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test_ok(self):
        response = self.client.get('/budget/kpm/')

        self.assertEqual(response.status_code, 200)

    def test_kpm_get_request_works_with_query_param(self):
        response = self.client.get("/budget/kpm/?fy=2015-16")
        self.assertEqual(response.status_code, 200)
        json_content = response.json()
        results = json_content['results']
        fiscal_years = [item["fy"] for item in results]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')

    def test_kpm_response_is_paginated(self):
        response = self.client.get('/budget/kpm/')

        json = response.json()

        self.assertTrue('count' in json)
        self.assertTrue('next' in json)
        self.assertTrue('previous' in json)
        self.assertTrue('results' in json)

    def test_kpm_accepts_page_query_param(self):
        # regression test
        response = self.client.get('/budget/kpm/', {'page': 1})
        self.assertEqual(response.status_code, 200)


class TestOcrbEndpoint(TestCase):
    def setup(self):
        self.client = Client()

    def test_ok(self):
        response = self.client.get('/budget/ocrb/')

        self.assertEqual(response.status_code, 200)

    def test_ocrb_get_request_works_with_query_param(self):
        response = self.client.get("/budget/ocrb/?fy=2015-16")
        self.assertEqual(response.status_code, 200)
        json_content = response.json()
        results = json_content['results']
        fiscal_years = [item["fy"] for item in results]

        for fiscal_year in fiscal_years:
            self.assertEqual(fiscal_year, '2015-16')

    def test_ocrb_response_is_paginated(self):
        response = self.client.get('/budget/ocrb/')

        json = response.json()

        # look for pagination keys
        self.assertTrue('count' in json)
        self.assertTrue('next' in json)
        self.assertTrue('previous' in json)
        self.assertTrue('results' in json)

    def test_ocrb_accepts_page_query_param(self):
        # regression test
        response = self.client.get('/budget/ocrb/', {'page': 1})
        self.assertEqual(response.status_code, 200)


class TestOcrbSummaryView(TestCase):

    def setup(self):
        self.client = Client()

    def test_ok(self):
        response = self.client.get('/budget/ocrb/summary/')
        self.assertEqual(response.status_code, 200)

    def test_kpm_response_is_paginated(self):
        response = self.client.get('/budget/ocrb/')

        json = response.json()

        # look for pagination keys
        self.assertTrue('count' in json)
        self.assertTrue('next' in json)
        self.assertTrue('previous' in json)
        self.assertTrue('results' in json)
