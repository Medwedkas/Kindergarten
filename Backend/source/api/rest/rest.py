from . import app
from .utils import Reply
from source.database import DbContext
from flask import request
from .middleware import *


@app.route('/api/')
def on_root():
    return Reply.ok()


@app.route('/api/create_token', methods=['POST'])
@app.validate('auth', 'signin')
def on_create_token():
    db = DbContext()
    status, token = db.create_token(request.json['username'], request.json['password'])

    if not status:
        return Reply.bad_request(error='Неверный логин или пароль')

    return Reply.ok(token=token)


@app.route('/api/check_token', methods=['GET'])
@protected
def on_check_token(user):
    return Reply.ok()


@app.route('/api/get_user_info', methods=['GET'])
@protected
def on_get_user_info(user=None):
    db = DbContext()
    try:
        if user['role'] == 1:
            tmp = db.get_parent_by_username(user['username'])
            user.update(tmp)
        elif user['role'] == 2:
            tmp = db.get_worker_by_username(user['username'])
            user.update(tmp)

        return Reply.ok(user=user)
    except:
        return Reply.bad_request()


@app.route('/api/get_children', methods=['GET'])
@protected
def on_get_children(user=None):
    db = DbContext()
    children = db.get_parent_children(user['username'])
    return Reply.ok(children=children)
