from pathlib import Path
import subprocess

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from prediction import (
    predict_response_time,
    reload_model,
)

from schemas import PredictionRequest

app = FastAPI(
    title="GuardWatch Emergency Response Prediction API",
    description="Predict emergency response time using Machine Learning.",
    version="1.0.0",
)

# ---------------------------------------------------
# CORS
# ---------------------------------------------------

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:5000",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)

# ---------------------------------------------------
# Routes
# ---------------------------------------------------

@app.get("/")
def root():
    return {
        "message": "Welcome to the GuardWatch Emergency Response Prediction API"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.post("/predict")
def predict(request: PredictionRequest):

    try:

        prediction = predict_response_time(
            request.model_dump()
        )

        return {
            "status": "success",
            "model": "Random Forest Regressor",
            "prediction": round(prediction, 2),
            "unit": "minutes",
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e),
        )


@app.post("/retrain")
def retrain():

    try:

        train_script = (
            Path(__file__).parent
            / "train.py"
        )

        result = subprocess.run(
            [
                "python",
                str(train_script),
            ],
            capture_output=True,
            text=True,
            check=True,
        )

        reload_model()

        return {
            "status": "success",
            "message": "Model retrained successfully.",
            "model_reloaded": True,
            "output": result.stdout,
        }

    except subprocess.CalledProcessError as e:

        raise HTTPException(
            status_code=500,
            detail=e.stderr,
        )