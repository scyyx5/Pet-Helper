from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
from keras.models import load_model
from flask import Flask, request, Response
import urllib.request
import psycopg2
import ssl

ssl._create_default_https_context = ssl._create_unverified_context

UPLOAD_FOLDER = '/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

if __name__ == "__main__":
    app = Flask(__name__)
    app.config['UPLOAD_FOLDER'] = "/temp/"
    app.config['MAX_CONTENT_LENGTH'] = 16 * 1000 * 1000
    

def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# load and prepare the image
def load_image(filename):
    # load the image
    img = load_img(filename, target_size=(224, 224))
    # convert to array
    img = img_to_array(img)
    # reshape into a single sample with 3 channels
    img = img.reshape(1, 224, 224, 3)
    # center pixel data
    img = img.astype('float32')
    img = img - [123.68, 116.779, 103.939]
    return img

if __name__ == "__main__":
    @app.route('/sendimage/', methods=['POST'])
    def upload_file():
        if request.method == 'POST':
            request_data = request.get_json()
            image_url = "https://pethelper.bham.team:8000" + request_data['pet_pic']
            urllib.request.urlretrieve(image_url, "temp.jpg")
            img = load_image("temp.jpg")
            model = load_model('final_model.h5')
            result = model.predict(img)
            if result[0] == 0:
                data = {
                    "pet_type": "Cat"
                }
            elif result[0] == 1:
                data = {
                    "pet_type": "Dog"
                }
            else:
                data = {
                    "pet_type": "Unknown"
                }
            conn = psycopg2.connect(
                database="PetHelper", user='doadmin', password='AVNS_NETbWnrj3m8tI-E',
                host='db-postgresql-lon1-38701-do-user-11009169-0.b.db.ondigitalocean.com', port='25060'
            )

            cursor = conn.cursor()
            sql = "UPDATE backend_pet SET pet_type = '" + data["pet_type"] + "' WHERE id = " + str(request_data["id"])
            print(sql)
            try:
                cursor.execute(sql)
                conn.commit()
            except:
                conn.rollback()

            sql = "SELECT * FROM backend_pet WHERE id = " + str(request_data["id"])
            print(sql)
            cursor.execute(sql)
            print(cursor.fetchall())
            conn.close()
            return Response("Image uploaded", status=201)
        return
    app.run(host='0.0.0.0', port=4444)
