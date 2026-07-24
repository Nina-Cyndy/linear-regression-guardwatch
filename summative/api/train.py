import joblib
import pandas as pd

from pathlib import Path

from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder, StandardScaler

print("Loading dataset...")

# ---------------------------------------------------
# Paths
# ---------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = BASE_DIR.parent

DATA_PATH = (
    PROJECT_DIR
    / "linear_regression"
    / "data"
    / "ambulance_established_ems.csv"
)

MODEL_DIR = (
    PROJECT_DIR
    / "linear_regression"
    / "model"
)

MODEL_DIR.mkdir(parents=True, exist_ok=True)

MODEL_PATH = MODEL_DIR / "guardwatch_response_model.pkl"

# ---------------------------------------------------
# Load Dataset
# ---------------------------------------------------

df = pd.read_csv(DATA_PATH)

print(f"Dataset loaded successfully ({df.shape[0]} rows).")

# ---------------------------------------------------
# Feature Engineering
# ---------------------------------------------------

target = "response_time_min"

columns_to_drop = [
    "id",
    target,
    "total_call_time_min",
    "transport_time_min",
    "on_scene_time_min",
    "met_target_response",
    "cfr_responded",
    "cfr_first_aid_given",
    "patient_reached_facility",
    "handover_to_facility",
    "documentation_complete",
]

X = df.drop(columns=columns_to_drop)
y = df[target]

categorical_features = X.select_dtypes(include=["object"]).columns.tolist()
numerical_features = X.select_dtypes(exclude=["object"]).columns.tolist()

print(f"Categorical features: {len(categorical_features)}")
print(f"Numerical features: {len(numerical_features)}")

# ---------------------------------------------------
# Preprocessing
# ---------------------------------------------------

preprocessor = ColumnTransformer(
    transformers=[
        (
            "num",
            StandardScaler(),
            numerical_features,
        ),
        (
            "cat",
            OneHotEncoder(handle_unknown="ignore"),
            categorical_features,
        ),
    ]
)

# ---------------------------------------------------
# Split Data
# ---------------------------------------------------

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
)

# ---------------------------------------------------
# Best Model (Random Forest)
# ---------------------------------------------------

model = Pipeline(
    steps=[
        ("preprocessor", preprocessor),
        (
            "model",
            RandomForestRegressor(
                n_estimators=200,
                random_state=42,
            ),
        ),
    ]
)

print("Training Random Forest model...")

model.fit(X_train, y_train)

print("Training complete.")

# ---------------------------------------------------
# Save Model
# ---------------------------------------------------

joblib.dump(model, MODEL_PATH)

print(f"Model saved successfully to:\n{MODEL_PATH}")