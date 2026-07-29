from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import pandas as pd

# Load the trained model and scaler
try:
    model = joblib.load("best_regression_model.pkl")
    scaler = joblib.load("input_scaler.pkl")
except Exception as e:
    raise RuntimeError(f"Error loading model or scaler: {e}")

# Create FastAPI app
app = FastAPI(
    title="Vehicle CO₂ Emissions Prediction API",
    description="Predicts vehicle CO₂ emissions using a trained regression model.",
    version="1.0.0"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Restrict this in production if needed
    allow_credentials=False,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)

# Request model
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
        "message": "Vehicle CO₂ Prediction API is running.",
        "status": "success"
    }


@app.post("/predict")
def predict(data: VehicleData):
    try:
        # Create DataFrame with EXACT feature names and order
        df = pd.DataFrame([{
            "year": data.year,
            "make": data.make,
            "model": data.model,
            "vehicle_class": data.vehicle_class,
            "engine_size": data.engine_size,
            "cylinders": data.cylinders,
            "transmission": data.transmission,
            "fuel_type": data.fuel_type,
            "fuel_city": data.fuel_city,
            "fuel_hwy": data.fuel_hwy,
            "fuel_comb": data.fuel_comb,
            "fuel_mpg": data.fuel_mpg,
        }])

        # Scale the features
        scaled_features = scaler.transform(df)

        # Predict CO₂ emissions
        prediction = model.predict(scaled_features)

        return {
            "predicted_co2": round(float(prediction[0]), 2),
            "unit": "g/km"
        }

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Prediction failed: {str(e)}"
        )
