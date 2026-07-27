from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

# Load the trained model and scaler
model = joblib.load("best_regression_model.pkl")
scaler = joblib.load("input_scaler.pkl")

app = FastAPI(
    title="Vehicle CO₂ Emissions Prediction API",
    description="Predicts vehicle CO₂ emissions using a trained Random Forest regression model.",
    version="1.0.0"
)

# Configure CORS
origins = [
    "http://localhost:3000",
    "http://localhost:8080",
    "http://localhost",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["POST"],
    allow_headers=["*"],
)


# Input validation model
class VehicleData(BaseModel):
    year: int
    make: int
    model: int
    vehicle_class: int

    engine_size: float = Field(..., ge=0.5, le=8.0)
    cylinders: int = Field(..., ge=2, le=16)

    transmission: int
    fuel_type: int

    fuel_city: float = Field(..., ge=2.0, le=40.0)
    fuel_hwy: float = Field(..., ge=2.0, le=40.0)
    fuel_comb: float = Field(..., ge=2.0, le=40.0)
    fuel_mpg: float = Field(..., ge=5.0, le=100.0)


@app.get("/")
def home():
    return {
        "message": "Vehicle CO₂ Prediction API is running."
    }


@app.post("/predict")
def predict(data: VehicleData):

    # Maintain the exact feature order used during training
    values = np.array([[
        data.year,
        data.make,
        data.model,
        data.vehicle_class,
        data.engine_size,
        data.cylinders,
        data.transmission,
        data.fuel_type,
        data.fuel_city,
        data.fuel_hwy,
        data.fuel_comb,
        data.fuel_mpg
    ]])

    # Scale input features
    values = scaler.transform(values)

    # Generate prediction
    prediction = model.predict(values)

    return {
        "predicted_co2": round(float(prediction[0]), 2),
        "unit": "g/km"
    }
