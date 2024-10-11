import unittest
import requests
import json
import jsonschema
from jsonschema import validate
import psycopg2

feedbackSchema = {
    "type": "object",
    "properties": {
        "id": {"type": "number"},
        "feedback": {"type": "string"},
    },
}

petSchema = {
    "type": "object",
    "properties": {
        "id": {"type": "number"},
        "pet_name": {"type": "string"},
        "pet_sex": {"type": "string"},
        "pet_type": {"type": "string"},
        "pet_birth": {"type": "string"},
        "pet_weight": {"type": "string"},
        "pet_pic": {"type": "string"},
        "pet_owner": {"type": "number"},
    },
}

petUserSchema = {
    "type": "object",
    "properties": {
        "id": {"type": "number"},
        "user_fname": {"type": "string"},
        "user_lname": {"type": "string"},
        "user_email": {"type": "string"},
        "user_password": {"type": "string"},
    },
}

def validateMultipleJSON(jsonData, currentSchema):
    try:
        for json1 in jsonData:
            validate(instance=json1, schema=currentSchema)
    except jsonschema.exceptions.ValidationError as err: 
        return False 
    return True

def validateJSON(jsonData, currentSchema):
    try:
        validate(instance=jsonData, schema=currentSchema)
    except jsonschema.exceptions.ValidationError as err: 
        return False 
    return True

class IntegrationTesting(unittest.TestCase):
    
    def test_valid_json_feedback_api(self):
        headers = {"Authorization": "Token 741cb94678eb31f0041402e66be7a35eb427e032"}
        response = requests.get("https://pethelper.bham.team:8000/api/v3/Feedback",headers = headers, verify=False)
        print(response.json())
        self.assertEqual(validateMultipleJSON(response.json(), feedbackSchema), True)
        self.assertEqual(response.status_code, 200)

    def test_valid_json_pet_api(self):
        headers = {"Authorization": "Token 741cb94678eb31f0041402e66be7a35eb427e032"}
        response = requests.get("https://pethelper.bham.team:8000/api/v3/Pets",headers = headers, verify=False)

        # self.assertEqual(validateMultipleJSON(response.json(), petSchema), True)
        self.assertEqual(response.status_code, 200)

    def test_add_feedback(self):
        headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token 741cb94678eb31f0041402e66be7a35eb427e032"}
        response = requests.post("https://pethelper.bham.team:8000/api/v3/Feedback/", json= {'feedback': 'TESTING'}, headers = headers, verify=False)
        self.assertEqual(validateJSON(response.json(), petSchema), True)
        print(response.json())
        self.assertEqual(response.status_code, 201)

        conn = psycopg2.connect(
            database="PetHelper", user='doadmin', password='AVNS_NETbWnrj3m8tI-E',
            host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com', port='25060'
        )

        cursor = conn.cursor()

        sql = "SELECT * FROM backend_feedback WHERE feedback = 'TESTING'"
        print(sql)
        cursor.execute(sql)
        print(cursor.fetchall())

        sql = "DELETE FROM backend_feedback WHERE feedback = 'TESTING'"
        print(sql)
        try:
            cursor.execute(sql)
            conn.commit()
        except:
            conn.rollback()

        conn.close()

    def test_add_user(self):

        response = requests.post("https://pethelper.bham.team:8000/api/v3/Register/", json= {
            "username": "AutoTestAccount",
            "password": "AutoMaticTesting123!",
            "password2": "AutoMaticTesting123!",
            "email": "auto_test@gmail.com",
            "first_name": "auto_test",
            "last_name": "auto_test"}, verify=False)
        print(response.json())
        self.assertEqual(validateJSON(response.json(), petUserSchema), True)

        print(response.status_code)
        self.assertEqual(response.status_code, 201)

        conn = psycopg2.connect(
            database="PetHelper", user='doadmin', password='AVNS_NETbWnrj3m8tI-E',
            host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com', port='25060'
        )

        cursor = conn.cursor()

        sql = "SELECT * FROM auth_user WHERE username = 'AutoTestAccount'"
        print(sql)
        cursor.execute(sql)
        print(cursor.fetchall())

        sql = "DELETE FROM backend_petowner2 WHERE user_id = (SELECT id FROM auth_user WHERE username = 'AutoTestAccount')"
        cursor.execute(sql)
        sql = "DELETE FROM auth_user WHERE username = 'AutoTestAccount'"
        print(sql)
        try:
            cursor.execute(sql)
            conn.commit()
        except:
            conn.rollback()

        conn.close()
