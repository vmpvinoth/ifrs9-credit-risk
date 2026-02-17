# Model Card — IFRS 9 Credit Risk Models

> Compliant with SR 11-7, SS3/18, and IFRS 9 documentation requirements.

---

## 1. Model Overview

| Field | Detail |
|-------|--------|
| **Model Name** | IFRS 9 ECL Framework — LendingClub |
| **Version** | 1.0 |
| **Model Type** | PD (Classification), LGD/EAD (Beta Regression) |
| **Development Date** | 2024 |
| **Developer** | — |
| **Regulatory Standard** | IFRS 9, Basel III IRB, SR 11-7, SS3/18 |

---

## 2. Intended Use

- **Primary use:** Estimation of 12-month and lifetime Expected Credit Loss (ECL) for consumer loan portfolios under IFRS 9.
- **Secondary use:** Capital adequacy calculations under Basel III IRB approach.
- **Out-of-scope:** Real-time scoring, fraud detection, marketing propensity models.

---

## 3. Training Data

| Dataset | Period | Rows | Source |
|---------|--------|------|--------|
| Development | 2007–2014 | ~466,000 | LendingClub public data |
| Out-of-Time (OOT) | 2015 | ~421,000 | LendingClub public data |

---

## 4. Target Variables

| Target | Definition | Clipping |
|--------|-----------|---------|
| `default_flag` | 1 if loan status ∈ {Charged Off, Default, Late, Grace Period} | — |
| `lgd` | (loan_amnt − total_rec_prncp − recoveries) / loan_amnt | [0.001, 0.999] |
| `ead_ratio` | funded_amnt / loan_amnt | [0.001, 0.999] |

---

## 5. Features Used

Key features after IV screening and Lasso selection:

- `grade_num` — LendingClub loan grade (A=1 to G=7)
- `int_rate` — Interest rate (%)
- `dti` — Debt-to-income ratio
- `annual_inc` — Annual income (winsorised)
- `loan_to_income` — Engineered: loan_amnt / annual_inc
- `revol_util` — Revolving utilisation rate
- `emp_length_num` — Employment length (years)
- `term_months` — Loan term (36 or 60 months)
- `inq_last_6mths` — Credit enquiries in last 6 months
- `delinq_2yrs` — Delinquencies in last 2 years

---

## 6. Model Performance

### PD Models

| Model | AUC-ROC | Gini | KS |
|-------|---------|------|----|
| Logistic Regression (Champion) | TBD | TBD | TBD |
| XGBoost (Challenger) | TBD | TBD | TBD |

### LGD Model (Beta Regression)

| Metric | Value |
|--------|-------|
| RMSE | TBD |
| MAE | TBD |
| R² | TBD |

### EAD Model (Beta Regression)

| Metric | Value |
|--------|-------|
| RMSE | TBD |
| MAE | TBD |
| R² | TBD |

> Fill in values after running the notebook with your data.

---

## 7. Known Limitations

1. **Static model** — trained on 2007–2014 data; economic cycle not fully represented.
2. **LGD uses accounting recoveries** — not economic loss adjusted for time value.
3. **No behavioural scoring** — uses application-time features only.
4. **LendingClub specific** — feature engineering tied to this originator's data schema.
5. **No macroeconomic overlays** — forward-looking adjustments (IFRS 9 §B5.5.28) not yet incorporated.

---

## 8. Monitoring & Governance

| Check | Frequency | Threshold | Action |
|-------|-----------|-----------|--------|
| PSI (Population Stability) | Monthly | >0.25 = Red | Redevelopment |
| AUC Drift | Quarterly | <0.65 = Red | Review |
| Default Rate vs Predicted PD | Monthly | >20% relative gap | Recalibration |

---

## 9. Regulatory Mapping

See [`regulatory_mapping.md`](regulatory_mapping.md) for full clause-level mapping.
