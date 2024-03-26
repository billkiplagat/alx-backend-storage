#!/usr/bin/env python3
""" 9-insert school module """


def insert_school(mongo_collection, **kwargs):
    """ Inserts a new document in a collection """
    document = mongo_collection.insert_one(kwargs)
    return document.inserted_id

