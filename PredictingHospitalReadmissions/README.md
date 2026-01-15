Predicting 30-day hospital readmission risk using the UCI Diabetes 130-US Hospitals dataset (1999–2008).
Quick Summary

Goal: Identify high-risk patients at discharge for targeted interventions
Dataset: ~101k encounters → cleaned to 99k rows × 110 features
Model: XGBoost (AUC 0.661 on test set – matches published benchmarks)
Top predictors: prior inpatient visits, medication changes, discharge disposition
Includes: trained model, SHAP explanations, interactive Streamlit demo

What’s in this repo

models/ – trained model
streamlit_app.py – simple risk calculator demo
White paper & presentation
