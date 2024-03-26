#!/usr/bin/env python3
""" 8-all module """


def list_all(mongo_collection):
    """ Lists all documents in a collection """
    documents = mongo_collection.find()
    return list(documents)

