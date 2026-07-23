from fastapi import FastAPI

app = FastAPI(
    title="GuardWatch Emergency Response Prediction API",
    description=(
        "Predicts emergency response time using a trained "
        "Random Forest regression model."
    ),
    version="1.0.0",
)


@app.get("/")
def root():
    return {
        "message": "Welcome to the GuardWatch Emergency Response Prediction API"
    }


@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "api": "running"
    }