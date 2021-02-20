from pathlib import Path
from fastai.vision.all import *
from settings import MODEL_PATHS

def detect(img,plant_type):
   
    plant = plant_type

    path = Path(MODEL_PATHS+f'{plant}.pkl')

    learn = load_learner(path)

    diagnosis,tensors,probs = learn.predict(img)

    return(str(diagnosis))