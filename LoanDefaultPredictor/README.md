# Loan Default Prediction

**Predicting consumer loan defaults using machine learning to help lenders reduce risk.**

### What this project is about
This is a predictive analytics project that builds classification models to identify borrowers likely to default on a loan.  
The goal: catch as many defaults as possible (high recall) while providing clear, actionable insights for banks and fintech companies.

- **Best result**: XGBoost with **98% recall** on defaults (AUC-ROC ≈ 0.73)
- **Key insight**: Age, dependents, and co-signers matter more than credit score alone in this dataset

### What's included in this repo

- **Notebooks**:
  - Exploratory data analysis & visualization
  - Full preprocessing (outlier capping, encoding, scaling, SMOTE, feature selection)
  - Model training, tuning & comparison (Logistic Regression, Random Forest, XGBoost)

- **Dataset**: Loan Default Prediction from Kaggle (255k rows, 18 features)  
  → Download required: https://www.kaggle.com/datasets/nikhil1e9/loan-default

- **Main findings**:
  - Top risk factors: younger age, having dependents, no co-signer
  - Recommendation: incentivize co-signers + offer counseling to high-risk groups

- **Tech stack**: Python, pandas, scikit-learn, XGBoost, SMOTE

### Quick performance summary

| Model              | AUC-ROC | Recall | Precision |
|--------------------|---------|--------|-----------|
| Logistic Regression| 0.75    | 0.80   | 0.18      |
| Random Forest      | 0.73    | 0.75   | 0.19      |
| **XGBoost**        | **0.73**| **0.98**| 0.13      |

