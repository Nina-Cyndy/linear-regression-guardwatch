# 🚑 GuardWatch Emergency Response Prediction

GuardWatch is an end-to-end Machine Learning application that predicts ambulance emergency response times based on emergency call information, incident characteristics, ambulance resources, and dispatch details.

The project combines:

- Machine Learning (Scikit-learn)
- FastAPI backend
- Flutter mobile application
- Render cloud deployment

The objective is to assist emergency response teams by estimating ambulance response time before dispatch, allowing better planning and resource allocation.

## 📌 Problem Statement

Emergency Medical Services (EMS) often face delays caused by traffic conditions, resource shortages, dispatch inefficiencies, and varying emergency priorities.

Accurately estimating ambulance response time helps:

- Improve dispatch planning
- Allocate emergency resources efficiently
- Reduce patient waiting time
- Support operational decision-making

This project uses historical EMS data to train a regression model capable of predicting expected ambulance response time.

## 💡 Solution

The solution consists of three major components:

1. A Machine Learning model trained using historical ambulance data.
2. A FastAPI REST API serving predictions.
3. A Flutter mobile application providing an intuitive interface for users to submit emergency information and receive predictions.

The trained Random Forest Regression model is deployed behind a FastAPI backend and accessed through HTTP requests from the Flutter application.

## 📊 Dataset

Dataset Name:

**Ambulance Established EMS Dataset**

The dataset contains emergency service records describing:

- Incident location
- Time of day
- Call type
- Emergency priority
- Caller information
- Dispatch details
- Ambulance availability
- Crew qualifications
- Equipment availability
- GPS tracking
- Alternative transportation
- Year

Target Variable:

- `response_time_min`

The dataset was cleaned, preprocessed, and used to train several regression algorithms.

## 🤖 Machine Learning Pipeline

The following preprocessing steps were applied:

- Data cleaning
- Feature selection
- Removal of data leakage variables
- One-Hot Encoding for categorical variables
- Standard Scaling for numerical variables
- Train/Test split (80/20)

Four regression algorithms were trained and compared.

## 📈 Models Evaluated

The following models were evaluated:

| Model | Test R² |
|--------|---------|
| Linear Regression | 0.460 |
| SGD Regressor | 0.460 |
| Decision Tree | -0.084 |
| Random Forest | **0.470** |

Random Forest achieved the best overall performance and was selected for deployment.

## 🏆 Best Model

After evaluating four regression algorithms, the **Random Forest Regressor** achieved the best performance and was selected for deployment.

### Model Performance

| Metric | Value |
|--------|---------:|
| Train MSE | 72.741 |
| Test MSE | 547.233 |
| Train RMSE | 8.529 |
| Test RMSE | 23.393 |
| Train MAE | 5.298 |
| Test MAE | 14.685 |
| Train R² | 0.927 |
| Test R² | **0.470** |

The Decision Tree model overfitted the training data, while the Linear Regression and SGD Regressor produced lower predictive performance. Random Forest provided the best balance between training accuracy and generalization, making it the most suitable model for deployment.

## 🌐 REST API

The machine learning model is deployed using **FastAPI** and hosted on **Render**.

### Live API

https://linear-regression-guardwatch-1.onrender.com

### Interactive Documentation

https://linear-regression-guardwatch-1.onrender.com/docs

The API accepts emergency incident details and returns the predicted ambulance response time in minutes.

## 🔌 API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | `/` | Welcome message |
| GET | `/health` | Health check |
| POST | `/predict` | Predict emergency response time |
| POST | `/retrain` | Retrain the machine learning model |

## 📱 Flutter Application

A Flutter mobile application was developed as the frontend interface for the prediction system.

The application allows users to:

- Enter emergency incident information
- Select categorical variables using dropdown menus
- Enter numerical values using text fields
- Send prediction requests to the deployed FastAPI backend
- Display the estimated emergency response time returned by the machine learning model

The application communicates with the deployed API using HTTP POST requests.

## 📂 Project Structure

```
linear-regression-guardwatch/
│
├── README.md
│
└── summative
    ├── api
    │   ├── app.py
    │   ├── main.py
    │   ├── prediction.py
    │   ├── schemas.py
    │   ├── train.py
    │   ├── requirements.txt
    │   └── render.yaml
    │
    ├── FlutterApp
    │   └── lib
    │
    └── linear_regression
        ├── multivariate.ipynb
        ├── data
        └── model
```

## ⚙️ Installation

Clone the repository

```bash
git clone https://github.com/Nina-Cyndy/linear-regression-guardwatch.git
```

Navigate into the project

```bash
cd linear-regression-guardwatch
```

### Backend

```bash
cd summative/api

pip install -r requirements.txt

uvicorn main:app --reload
```

### Flutter

```bash
cd summative/FlutterApp

flutter pub get

flutter run
```

## 📸 Screenshots

### Flutter Application

| Home Screen | Prediction |
|--------------|------------|
| *(Insert Screenshot)* | *(Insert Screenshot)* |

### API Documentation

| Swagger UI |
|-------------|
| *(Insert Screenshot)* |

### Machine Learning

| Model Comparison |
|------------------|
| *(Insert Model Comparison Graph)* |

| Feature Correlation |
|---------------------|
| *(Insert Correlation Plot)* |

## 🚀 Future Improvements

Potential future enhancements include:

- Real-time traffic integration
- GPS route optimization
- Weather-based prediction features
- User authentication
- Historical prediction tracking
- Continuous model retraining
- Docker containerization
- CI/CD pipeline integration


## 👩‍💻 Author

**Nina Cyndy Bwiza**

African Leadership University

Machine Learning Summative Project

GitHub: https://github.com/Nina-Cyndy