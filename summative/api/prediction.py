from pathlib import Path

import joblib
import pandas as pd

MODEL_PATH = (
    Path(__file__).resolve().parent.parent
    / "linear_regression"
    / "model"
    / "guardwatch_response_model.pkl"
)

model = joblib.load(MODEL_PATH)


def predict_response_time(data: dict) -> float:
    """
    Predict emergency response time.
    """

    df = pd.DataFrame([data])

    prediction = model.predict(df)

    return float(prediction[0])