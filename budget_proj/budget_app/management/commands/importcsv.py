#!/usr/bin/env python3

# Idea: For every record in the CSV file
#     model_values = {}
#     Iterate over fields
#     Convert corresponding CSV value to the value
#     Add to model_values

import csv
import argparse
import sys

from django.db import models
from django.db import transaction
from django.db.models import loading
from django.core.management.base import BaseCommand, CommandError


DEFAULT_APP = "budget_app"

class Command(BaseCommand):
    help = 'Import a CSV file into a model'

    def add_arguments(self, parser):
        parser.add_argument("model",
                            help="Name of model (app.model), app defaults to apiv1")
        parser.add_argument("infile", type=argparse.FileType('r'),
                            default=sys.stdin)
        parser.add_argument("mappings", nargs="*",
                            help="csv:database mappings")

    def handle(self, *args, **options):
        model = get_model(options['model'])
        field_to_header = parse_mappings(options['mappings'])
        insert(options['infile'], model, field_to_header)


def get_model(model_path):
    if "." in model_path:
        app_label, model_name = model_path.split(".")
    else:
        app_label = DEFAULT_APP
        model_name = model_path
    return loading.get_model(app_label, model_name)


def parse_mappings(mappings):
    field_to_header = {}
    for mapping in mappings:
        header, field = mapping.split(":")
        field_to_header[field] = header
    return field_to_header


@transaction.atomic
def insert(infile, model, field_to_header):
    with infile as f:
        reader = csv.DictReader(f)
        for csv_record in reader:
            db_values = {}
            for field in model._meta.get_fields():
                header = field_to_header.get(field.name, field.name)
                value = csv_record[header]
                db_values[field.name] = value
            db_record = model(**db_values)
            db_record.save()
