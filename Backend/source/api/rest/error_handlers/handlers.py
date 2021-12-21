from .. import app
from jsonschema import ValidationError
from ..utils import Reply


@app.errorhandler(ValidationError)
def on_validation_error(e):
    return Reply.bad_request(error=str(e).replace('\n', ' ').strip())