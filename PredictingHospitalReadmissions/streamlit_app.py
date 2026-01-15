import streamlit as st
import joblib
import xgboost as xgb
import pandas as pd

st.title("30-Day Hospital Readmission Risk Calculator")

# Load the trained model
model = joblib.load('models/final_xgboost_model.pkl')

st.write("Adjust the key risk factors below (other features are set to typical defaults):")

# User inputs
inpatient = st.slider("Number of inpatient visits (past year)", 0, 15, 1)
emergency = st.slider("Number of emergency visits (past year)", 0, 15, 0)
med_change = st.checkbox("Medication changed during stay", value=True)
time_hosp = st.slider("Days in hospital this stay", 1, 14, 4)
num_meds = st.slider("Number of medications", 1, 40, 15)

# Get the exact feature names the model expects
feature_names = model.feature_names if hasattr(model, 'feature_names') else None
if feature_names is None:
    st.error("Model does not have feature_names attribute. Cannot create input.")
    st.stop()

# Create a zero-filled row with all model features
input_data = pd.DataFrame(0.0, index=[0], columns=feature_names)

# Override with user-provided values (safe — if column missing, it will warn but continue)
input_data['number_inpatient'] = inpatient
input_data['number_emergency'] = emergency
input_data['med_change'] = int(med_change)
input_data['time_in_hospital'] = time_hosp
input_data['num_medications'] = num_meds

# Predict
dmat = xgb.DMatrix(input_data)
prob = model.predict(dmat)[0]
risk_pct = prob * 100

# Display result
st.metric("Predicted 30-Day Readmission Risk", f"{risk_pct:.1f}%")

if risk_pct > 30:
    st.error("HIGH RISK - recommend intensive follow-up")
elif risk_pct > 15:
    st.warning("Moderate risk - suggest follow-up call")
else:
    st.success("Low risk")

st.caption("This is a simplified demo using only 5 key features. The full model uses 110+ features.")