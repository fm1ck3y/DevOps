from flask import jsonify, request
from app import app
import app.database as database
from functools import wraps

def logging_request(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        response_args = {
            'ip': request.remote_addr,
            'args': dict((key, request.args.get(key)) for key in request.args)
        }
        app.logger.info(response_args)
        return f(*args, **kwargs)

    return wrapper

@app.errorhandler(404)
def not_found(error=None):
    return jsonify({
        'code': 0,
        'response': 'Not Found'
    })


@app.route('/without_json/api/v1.0/add_user', methods=['GET'])
@logging_request
def add_user():
    email = request.args.get('email')
    username = request.args.get('username')
    full_name = request.args.get('full_name')
    information_bio = request.args.get('information_bio')
    password = request.args.get('password')
    if email is None or username is None or full_name is None or information_bio is None or password is None:
        print("c")
        response = {'code': 409, 'response': 'Conflict'}
    elif database.Database().add_user(email,username,full_name,information_bio,password):
        print("d")
        response = { 'code': 201, 'response': 'Created'}
    else:
        response = {'code': 409,'response': 'Conflict'}
    return jsonify(response)
