from flask import Flask, jsonify, request
from settings import *
from model import detect
from fastai.vision.all import *
import base64

app = Flask(__name__)


@app.route('/classify', methods=['POST'])
def classify():
    
    print('Starting...')
    data = request.form
    plant_type = data['plant_type']
    # print(base64.b64decode(request.files['file'].read())[:10])
    img = PILImage.create(base64.b64decode(request.files['file'].read()))
    # import pdb; pdb.set_trace()
    print('Detecting...')
    diagnosis = detect(img,plant_type)
    response = {'diagnosis': diagnosis}
    return jsonify(response)


if __name__ == "__main__":
    app.run(host=HOST, port=PORT, debug=True)
