import joblib
import pandas as pd

model = joblib.load("best_regression_model.pkl")
scaler = joblib.load("input_scaler.pkl")

def predict_co2(data: dict):
    df = pd.DataFrame([data])
    df_scaled = scaler.transform(df)
    prediction = model.predict(df_scaled)
    return float(prediction[0])
