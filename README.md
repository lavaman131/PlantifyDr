# PlantifyDr 🌿

A mobile application utilizing 2D Convolutional Neural Networks (CNNs) to diagnose crop diseases through image classification of plant leaves.

![](images/PlantifyDr-feature-graphic.png)
![](images/iOSImage.png)

## Table of Contents

- [Machine Learning Notebooks](notebooks)
  - [Plant models](notebooks/plants)
  - [Experiments with transfer learning](notebooks/experiments)
  - [Model visualization](images/Resnet50.onnx.png)
- [iOS App Code](PlantifyDr_iOS)
- [Deployment Code](plantifydr)

## Built With

- [fastai](https://docs.fast.ai/) - A deep learning library written in Python based off of PyTorch
- [Flask](https://flask.palletsprojects.com/en/1.1.x/) - Used as web framework for deployment
- [Docker Compose](https://docs.docker.com/compose/) - Used to run application
- [WSGI](https://wsgi.readthedocs.io/en/latest/what.html) - Web Server Gateway Interface to communicate with web application
- [AWS](https://aws.amazon.com/) - For hosting ML models
- [Swift](https://developer.apple.com/swift/) - For creating iOS app
  <!-- ![](images/Resources.png) -->

### Flowchart

![](images/Flowchart.jpg)

## Deep Learning techniques used

1. **Model training** with `Learning rate (LR) scheduler` using `cosine annealing` as opposed to more traditional LR scheduling from `lr_max/div` to `lr_max` where `div` is a number (100000.0 in my case & default for fastai library) for optimal learning rate for better training results

2. **Fine tuning model** with `freeze` for `freeze_epochs` (transfer learning) then with `unfreeze` from epochs using `discriminative LR` (lower LR for earlier layers and greater LR for later layers)

![](images/Flowchart.jpg)

## Results

My final models each achieved a validation accuracy of 99.0%.

![](images/Tomato_Table.png)

## Get my app

- [iOS](https://apps.apple.com/us/app/plantifydr/id1530756725)
- [Android](https://play.google.com/store/apps/details?id=com.onrender.plantify) - working on update
- [Website](https://plantify.onrender.com/) - working on update

## Authors

- **Alex Lavaee**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

See the [Credits.md](Credits.md) file for details
