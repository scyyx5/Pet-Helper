from rest_framework import status
from rest_framework.test import APITestCase, APIClient
import requests

SECURE_SSL_REDIRECT = True

class UserTestCase(APITestCase):

	@classmethod
	def setUpClass(cls):
		super().setUpClass()
		cls.info_url = 'https://pethelper.bham.team:8000/api/v3/Information/'

	def test_if_information_works(self):
		response = requests.get(self.info_url, verify=False)
		self.assertEqual(response.status_code, status.HTTP_200_OK)

'''
	def test_if_signup_works(self):
		signup_dict = {
			'username': 'fakeusername' + str(random.randint(0,99999999999)),
			'password'    : 'FakeP12@ssword',
			'password2':'FakeP12@ssword',
			'email':'fakeemail@gmail.com',
			'first_name' : 'fake_first_name',
			'last_name':'fake_last_name'
		}
		response = self.client.post(self.signup_url, signup_dict)

		self.assertEqual(response.status_code, status.HTTP_201_CREATED)
'''


# DATABASES = {
# 	'default': {
# 		'ENGINE': 'django.db.backends.postgresql',
# 		'NAME': 'TestDB',
# 		'USER': 'doadmin',
# 		'PASSWORD': 'AVNS_NETbWnrj3m8tI-E',
# 		'HOST': 'db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com',
# 		'PORT': '25060'
# 	}
# }

REST_FRAMEWORK = {
	'DEFAULT_PARSER_CLASSES': [
		'rest_framework_xml.parsers.XMLParser',
	],
	'DEFAULT_RENDERER_CLASSES': [
		'rest_framework_xml.renderers.XMLRenderer',
	],
}
