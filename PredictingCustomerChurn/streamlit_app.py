import streamlit as st
import joblib
import xgboost as xgb
import pandas as pd

st.title("Telco Customer Churn Risk Calculator")

model = joblib.load("models/final_xgboost_model.pkl")

st.write("Enter customer details:")

tenure = st.slider("Tenure (months)", 0, 72, 12)
monthly = st.number_input("Monthly Charges ($)", 10.0, 150.0, 70.0)
contract_month = st.checkbox("Month-to-Month Contract", value=True)
internet_fiber = st.checkbox("Fiber Optic Internet", value=False)
tech_support = st.checkbox("Has Tech Support", value=False)

input_data = pd.DataFrame(0.0, index=[0], columns=model.feature_names)
input_data["tenure"] = tenure
input_data["MonthlyCharges"] = monthly

if "Contract_Month-to-month" in input_data.columns:
    input_data["Contract_Month-to-month"] = int(contract_month)
if "InternetService_Fiber optic" in input_data.columns:
    input_data["InternetService_Fiber optic"] = int(internet_fiber)
if "TechSupport_Yes" in input_data.columns:
    input_data["TechSupport_Yes"] = int(tech_support)

dmat = xgb.DMatrix(input_data)
prob = model.predict(dmat)[0]
risk = prob * 100

st.metric("Predicted Churn Risk", f"{risk:.1f}%")

if risk > 50:
    st.error("HIGH RISK - immediate outreach recommended")
elif risk > 30:
    st.warning("Elevated risk - consider offer")
else:
    st.success("Low risk")