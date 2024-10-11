import unittest
from catvsdog import load_image,load_model 

def test_cat():
    img = load_image("cat.jpg")
    model = load_model('final_model.h5')
    result = model.predict(img)
    if result[0] == 0:
        return True
    elif result[0] == 1:
        return False
    else:
        return False

def test_dog():
    img = load_image("dog.png")
    model = load_model('final_model.h5')
    result = model.predict(img)
    if result[0] == 0:
        return False
    elif result[0] == 1:
        return True
    else:
        return False

class AiUnitTesting(unittest.TestCase):
    dog_result = test_dog()
    cat_result = test_cat()

    def test_dog_pass(self):
        self.assertEqual(self.dog_result, True)

    def test_cat_pass(self):
        self.assertEqual(self.cat_result, True)
