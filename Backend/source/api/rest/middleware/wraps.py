import functools
from flask import request, abort
from source.database import DbContext


def protected(f):
    @functools.wraps(f)
    def decorated_function(user=None, *args, **kwargs):
        db = DbContext()
        user = db.check_token(request.headers.get('Authorization', '').replace('Bearer ', ''))
        if not user:
            abort(403)
        return f(user=user[1], *args, **kwargs)

    return decorated_function
