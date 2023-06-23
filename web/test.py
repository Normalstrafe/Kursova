import unittest
from app import app

class FlaskAppTestCase(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.client = app.test_client()

    def test_hello_world(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        expected_message = 'Hello, World!'
        with open('message.txt', 'r') as file:
            expected_message = file.read().strip()
        self.assertEqual(response.data.decode('utf-8'), expected_message)

if __name__ == '__main__':
    unittest.main()