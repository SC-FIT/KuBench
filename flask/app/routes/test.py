import time
import random

from flask import Blueprint, request, jsonify, make_response
from sqlalchemy import text
from app import db
from app.models.group import Group
from app.models.user import User
from app.models.usergroupstate import Usergroupstate
from app.services.test_service import TestService


test = Blueprint('test', __name__)

@test.route('/test', methods=['GET'])
def test_route():
    return jsonify({'message': 'Test route works!'})


@test.route('/test/device', methods=['GET'])
def test_device():
    device = {
        "deviceName": "My Awesome Device",
        "deviceModel": "Model 123",
        "deviceOS": "Android 13",
        "appVersion": "1.2.3",
        "deviceID": "unique_device_id",
        "screenResolution": "1080x1920",
        "carrierName": "Carrier X",
        "locale": "en_US",
        "timezone": "America/Los_Angeles"
    }
    return jsonify(device)

@test.route('/test/random-sleep', methods=['GET'])
def test_random_sleep():
    min_sleep = 2000 / 1000
    max_sleep = 5000 / 1000
    time.sleep(random.uniform(min_sleep, max_sleep))
    return make_response('', 204)

@test.route('/test/file-upload', methods=['POST'])
def upload():
    test_service = TestService(User, Group, Usergroupstate)
    file = request.files.get('file')
    if not file:
        return {'error': 'No file uploaded'}, 400

    try:
        test_service.handle_file_upload(file)
        return {'message': 'File processed successfully'}, 200
    except Exception as e:
        return {'error': str(e)}, 500

@test.route('/test/complex-select', methods=['GET'])
def test_complex_select():
    result = complex_select_test()
    return jsonify(result)

def complex_select_test():
    sql_query = text("""
    SELECT 
        u.id AS user_id,
        g.name AS group_name,
        g.contract_number,
        g.institute_name,
        g.institute_address_name,
        g.city,
        u.name,
        u.surname,
        u.login,
        u.email,
        u.phone,
        s.label AS status_name,
        u.is_dsm_admin,
        u.is_group_admin,
        u.is_planner,
        u.is_support_tech,
        u.photo
    FROM 
        public."user" u
    JOIN public.usergroupstate s ON (u.state_id = s.id)
    JOIN public."group" g ON (u.group_id = g.id)
    """)
    result = db.session.execute(sql_query)
    column_names = result.keys()
    return [dict(zip(column_names,row)) for row in result]