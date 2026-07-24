from pathlib import Path

import joblib
import pandas as pd

# ---------------------------------------------------
# Model Path
# ---------------------------------------------------

MODEL_PATH = (
    Path(__file__).resolve().parent.parent
    / "linear_regression"
    / "model"
    / "guardwatch_response_model.pkl"
)

model = None


def load_model():
    """
    Load the trained model from disk.
    """
    global model

    model = joblib.load(MODEL_PATH)

    print("Model loaded successfully.")


def reload_model():
    """
    Reload the model after retraining.
    """
    load_model()


load_model()


def predict_response_time(data: dict) -> float:
    """
    Predict emergency response time.
    """

    global model

    df = pd.DataFrame([data])

    prediction = model.predict(df)

    return float(prediction[0])