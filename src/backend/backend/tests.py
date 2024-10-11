from django.test import TestCase
from django.test import Client
# Create your tests here.
import unittest
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

c = Client()

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

class SystemTesting(unittest.TestCase):
    def test_invalid_user(self):

        response = c.post("/PetUser/", json= {"user_fname": "UNIQUETEXT2324441111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111", "user_lname": "UNIQUETEXT232444", "user_email": "UNIQUETEXT232444@gmail.com"})

        self.assertNotEqual(response.status_code, 200)
        
        conn = psycopg2.connect(
            "dbname='PetHelper' user='doadmin' host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com' password='AVNS_NETbWnrj3m8tI-E' port='25060'")

        cursor = conn.cursor()

        sql = "DELETE FROM backend_petuser WHERE user_fname = 'UNIQUETEXT2324441111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111'"
        # print(sql)
        try:
            cursor.execute(sql)
            conn.commit()
        except:
            conn.rollback()

        conn.close()


    def test_invalid_user2(self):

        response = c.post("/PetUser/", json= {"user_fname": "UNIQUETEXT232444", "user_lname": "UNIQUETEXT232444", "user_email": "UNIQUETEXT232444", "user_password": "UNIQUETEXT232444"})

        self.assertNotEqual(response.status_code, 200)

        conn = psycopg2.connect(
            "dbname='PetHelper' user='doadmin' host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com' password='AVNS_NETbWnrj3m8tI-E' port='25060'")

        cursor = conn.cursor()

        sql = "DELETE FROM backend_petuser WHERE user_fname = 'UNIQUETEXT232444'"
        # print(sql)
        try:
            cursor.execute(sql)
            conn.commit()
        except:
            conn.rollback()

        conn.close()

    def test_add_pet(self):

        response = c.post("/Pet/", json= {"pet_name":"asdas445","pet_sex":"M","pet_type":"Cat","pet_birth":"2022-03-10","pet_weight":"1","pet_pic":"http://127.0.0.1:8000/media/images/image_picker8199144184233362086_2JPndcN.webp"})

        self.assertNotEqual(response.status_code, 200)

        conn = psycopg2.connect(
            "dbname='PetHelper' user='doadmin' host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com' password='AVNS_NETbWnrj3m8tI-E' port='25060'")

        cursor = conn.cursor()

        sql = "DELETE FROM backend_pet WHERE pet_name = 'asdas445'"
        # print(sql)
        try:
            cursor.execute(sql)
            conn.commit()
        except:
            conn.rollback()

        conn.close()


    def test_invalid_api(self):
        response1 = c.post("/Pet/")
        self.assertNotEqual(response1.status_code, 200)

        response2 = c.post("/Feedback/")
        self.assertNotEqual(response2.status_code, 200)

        response3 = c.post("/Calendar/")
        self.assertNotEqual(response3.status_code, 200)

        response4 = c.post("/PetUser/")
        self.assertNotEqual(response4.status_code, 200)

