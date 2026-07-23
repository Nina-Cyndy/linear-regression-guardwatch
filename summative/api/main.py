from fastapi import FastAPI, HTTPException

from prediction import predict_response_time
from schemas import PredictionRequest

app = FastAPI(
    title="GuardWatch Emergency Response Prediction API",
    description=(
        "Predict emergency response times using "
        "a trained Random Forest regression model."
    ),
    version="1.0.0",
)


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
            "unit": "minutes"
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )