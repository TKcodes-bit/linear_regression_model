# Vehicle Tailpipe CO₂ Emission Prediction Engine

## Mission & Problem Statement

This project develops a machine learning system capable of predicting vehicle tailpipe CO₂ emissions based on key vehicle specifications. The goal is to support environmental monitoring agencies, automotive researchers, and consumers by estimating carbon output without requiring physical laboratory testing.

The system uses vehicle attributes such as engine size, cylinder count, fuel consumption, and transmission type to estimate CO₂ emissions in grams per kilometer (g/km).

#Source
*https://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64/resource/581ab81d-fe7f-4beb-9f31-e1b8e7552cb6*

---

# Public API Service

Base URL:
https://vehicle-co2-api.onrender.com

Prediction:
https://vehicle-co2-api.onrender.com/predict

Swagger:
https://vehicle-co2-api.onrender.com/docs

# Task 1: Machine Learning Model Development Lifecycle

## 1. Dataset Description

To satisfy the automotive domain requirements, this project uses a vehicle performance dataset containing unique vehicle configurations.

### Dataset Source

Vehicle diagnostic and fuel-performance records aggregated from publicly available automotive datasets.

### Prediction Target

The target variable is:

```
CO2_Emissions
```

Measured in:

```
grams per kilometer (g/km)
```

### Input Features

The model uses the following vehicle characteristics:

| Feature               | Description                                          |
| --------------------- | ---------------------------------------------------- |
| Engine_Size           | Engine displacement in liters                        |
| Cylinders             | Number of engine cylinders                           |
| Fuel_Consumption_Comb | Combined fuel consumption in L/100km                 |
| Transmission          | Manual or Automatic transmission encoded numerically |

---

# 2. Exploratory Data Analysis

Exploratory Data Analysis (EDA) was performed to understand relationships between vehicle characteristics and CO₂ emissions.

## Key Findings

* Fuel consumption demonstrated the strongest relationship with CO₂ emissions.
* Larger engines generally produced higher carbon emissions.
* Cylinder count showed correlation with engine size and emission levels.

Correlation analysis showed that fuel consumption was the strongest predictor of vehicle emissions.

---

# 3. Feature Engineering

Before training, raw vehicle information was transformed into machine-readable numerical values.

## Categorical Encoding

Transmission values were converted:

```
Manual = 0
Automatic = 1
```

This allowed regression algorithms to process categorical information mathematically.

---

# 4. Feature Scaling

Vehicle features exist on different numerical ranges:

Example:

```
Engine Size:
0.5L - 8.0L

Cylinders:
2 - 16
```

To prevent larger numerical features from dominating model optimization, StandardScaler was applied.

The transformation follows:

[
z = \frac{x-\mu}{\sigma}
]

After scaling:

[
\mu = 0
]

[
\sigma = 1
]

This ensures consistent model training performance.

---

# 5. Regression Algorithm Evaluation

Multiple regression algorithms were trained and evaluated using:

* Mean Squared Error (MSE)
* R² Score

The evaluated models included:

## Linear Regression

Uses Ordinary Least Squares to calculate optimal regression coefficients.

## Ridge Regression

Applies L2 regularization to reduce overfitting.

Configuration:

```
alpha = 1.0
```

## Lasso Regression

Uses L1 regularization to reduce unnecessary feature influence.

Configuration:

```
alpha = 0.1
```

## Stochastic Gradient Descent Regression

Uses iterative optimization suitable for scalable machine learning pipelines.

---

# Model Selection

The best-performing regression model was selected based on the lowest validation MSE.

The trained artifacts were exported:

```
best_regression_model.pkl
input_scaler.pkl
```

These files are loaded by the FastAPI production service for real-time predictions.

---

# Task 2: FastAPI Backend Architecture

## Framework

The backend API is implemented using:

* FastAPI
* Pydantic validation
* Scikit-learn model inference

---

# API Request Validation

Incoming prediction requests are validated using Pydantic models.

Accepted ranges:

| Parameter        | Validation         |
| ---------------- | ------------------ |
| Engine Size      | 0.5 - 8.0 Liters   |
| Cylinders        | 2 - 16             |
| Fuel Consumption | 2.0 - 40.0 L/100km |
| Transmission     | 0 - 1              |

Invalid requests automatically return:

```
422 Unprocessable Entity
```

---

# Prediction Endpoint

Example request:

```json
{
  "engine_size": 2.5,
  "cylinders": 6,
  "fuel_consumption": 9.5,
  "transmission": 1
}
```

Example response:

```json
{
  "prediction": 220.5,
  "unit": "g/km"
}
```

---

# CORS Configuration

The API includes CORS middleware to support communication with external clients including:

* Flutter mobile applications
* Web clients
* Development environments

Current configuration allows cross-platform development:

```python
allow_origins=["*"]
```

For production deployment, this can be restricted to trusted domains.

---

# Model Retraining Capability

The architecture supports future model updates through a retraining endpoint.

Future improvements include:

* Automated data collection
* Model monitoring
* Performance tracking
* Periodic retraining pipelines

---

# Task 3: Flutter Mobile Application

The client application provides a simple interface for users to estimate vehicle emissions.

## Main Features

### Vehicle Input Form

Users provide:

* Engine size
* Number of cylinders
* Fuel consumption
* Transmission type

---

## Input Validation

The Flutter application performs client-side validation before sending requests.

Benefits:

* Faster feedback
* Reduced invalid API requests
* Better user experience

---

## Prediction Workflow

The application:

1. Collects user vehicle information
2. Converts inputs into JSON
3. Sends a POST request to FastAPI
4. Receives the predicted CO₂ emission value
5. Displays the result dynamically

---

## User Interface States

The application handles:

### Loading State

Displays progress while waiting for the API response.

### Success State

Shows predicted CO₂ emissions.

Example:

```
Estimated Emission:
220.5 g/km
```

### Error State

Displays meaningful error messages for:

* Invalid inputs
* Network failures
* API errors

---

# Task 4: Production Deployment

## Backend Deployment

The FastAPI service can be deployed using:

* Render
* Docker
* Cloud hosting platforms

Required deployment files:

```
API/
│
├── main.py
├── best_regression_model.pkl
├── input_scaler.pkl
├── requirements.txt
└── venv/
```

---

# Running Locally

## Install Dependencies

```bash
pip install -r requirements.txt
```

## Start API Server

```bash
uvicorn main:app --reload
```

The API will run at:

```
http://127.0.0.1:8000
```

Swagger documentation:

```
http://127.0.0.1:8000/docs
```

---

# Demonstration Video Structure

The final presentation will demonstrate:

## 1. Problem Introduction

Explain the environmental challenge and project motivation.

## 2. Machine Learning Pipeline

Show:

* Dataset
* Feature engineering
* Model training
* Evaluation metrics

## 3. Backend Demonstration

Demonstrate:

* FastAPI server
* Swagger documentation
* Prediction requests

## 4. Flutter Application Demo

Show:

* User input
* API communication
* Prediction display

## 5. Conclusion

Explain:

* Real-world applications
* Future improvements
* Environmental impact

---

# Future Improvements

Possible enhancements include:

* Larger real-world vehicle datasets
* Deep learning comparison
* Cloud model monitoring
* Authentication and user accounts
* Historical emission tracking
* Integration with vehicle databases

---

# Author

Thomas Kweya Odongo

African Leadership University
Software Engineering
