# AI-Predicts-Particle-Collisions

The code uses TensorFlow to predict particle collision outcomes from a dataset of collision images, in `pkl` format. It outputs the results of the model at different train sample sizes to a `csv` file. 

This `csv` file can be run with the R script to create scatterplots and histograms of the model's accuracy, allowing for easy analysis and presentation. 

The model is supported by Python versions 3.9 and higher. The graphing-producing script is supported by R versions 4.2.1 and higher. 

## `R Data Analysis` folder
* Contains results from tests in `csv` file
* Contains Rmarkdown file with data analysis code

## `__pycache__` folder
* For implementing the quantum neural network

## `data` folder
* Contains the particle collision images in `pkl` format

## `images` folder
* Noteworthy images from our experiments

## `main.ipynb` folder
* TensorFlow model code and experiment code for the particle collisions
