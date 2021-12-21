from flask import Flask
from flask_jsonschema_validator import JSONSchemaValidator

app = Flask(__name__)
JSONSchemaValidator(app=app, root="source/api/rest/schemas")

from .rest import *
from .error_handlers import *