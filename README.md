# 🏦 IFRS 9 Credit Risk Modelling — LendingClub Loan Portfolio

> **End-to-End Production Framework | Tier-1 Bank | Model Risk Management**

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Regulatory](https://img.shields.io/badge/Compliant-IFRS%209%20%7C%20Basel%20III%20%7C%20SR%2011--7-orange)]()

---

## 📌 Overview

This repository implements a full **IFRS 9 Expected Credit Loss (ECL)** modelling pipeline on the LendingClub public loan dataset. It covers all three ECL components:

| Component | Target Variable | Model |
|-----------|----------------|-------|
| **PD** — Probability of Default | `default_flag` (0/1) | Logistic Regression + XGBoost |
| **LGD** — Loss Given Default | `lgd` ∈ [0, 1] | Beta Regression |
| **EAD** — Exposure at Default | `ead_ratio` ∈ [0, 1] | Beta Regression |

**ECL Formula:**
$$\text{ECL} = PD \times LGD \times EAD \times DF$$

Where **DF** = discount factor (~0.97 for 12-month horizon).

---

## 📁 Repository Structure

```
ifrs9-credit-risk/
│
├── notebooks/
│   └── IFRS9_LendingClub_CreditRisk.ipynb   # Main end-to-end notebook
│
├── data/
│   ├── loan_data_2007_2014.csv               # Development dataset (not tracked by git)
│   └── loan_data_2015.csv                    # OOT / PSI dataset   (not tracked by git)
│
├── outputs/
│   ├── cell07_targets.png                    # PD/LGD/EAD distributions
│   ├── cell18_lr_coefficients.png            # Logistic regression coefficients
│   └── ...                                   # All saved plots from notebook
│
├── docs/
│   ├── model_card.md                         # Model card (SR 11-7 / SS3/18)
│   └── regulatory_mapping.md                 # IFRS 9 / Basel III clause mapping
│
├── scripts/
│   └── run_notebook.sh                       # Headless notebook execution script
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

## 🏛️ Regulatory Framework

| Standard | Authority | Coverage in this Repo |
|----------|-----------|----------------------|
| **IFRS 9** | IASB | ECL, 3-stage impairment, SICR triggers |
| **Basel III** | BCBS | IRB PD floor, downturn LGD, RWA |
| **SR 11-7** | Federal Reserve | Model dev, validation, governance |
| **SS3/18** | PRA / Bank of England | Model design, stress testing |
| **BCBS 239** | BCBS | Risk data aggregation, quality |

---

## 🔄 Pipeline — Notebook Cells

| Cell | Section |
|------|---------|
| 1–2 | Business problem & regulatory mapping |
| 3–4 | Data import & quality checks (BCBS 239) |
| 5–6 | Missing value treatment & outlier winsorisation |
| **7** | **Target variable definition — PD / LGD / EAD** |
| 8 | Exploratory data analysis |
| 9–13 | Feature engineering, WoE, IV screening, encoding |
| 14–17 | Feature selection (Lasso, Ridge, Elastic Net, PCA) |
| 18–19 | Logistic Regression — PD Champion model |
| 20–23 | Beta Regression — LGD & EAD models |
| 24–25 | XGBoost — PD Challenger model |
| 26 | Champion vs Challenger comparison (SR 11-7) |
| 27 | PD / LGD / EAD calibration |
| 28 | IFRS 9 ECL calculation & stage allocation |
| 29–30 | PSI monitoring & RAG dashboard |
| 31–34 | Governance, limitations, conclusion |

---

## ⚙️ Setup & Installation

### 1. Clone the repository
```bash
git clone https://github.com/your-username/ifrs9-credit-risk.git
cd ifrs9-credit-risk
```

### 2. Create a virtual environment
```bash
python -m venv venv
source venv/bin/activate        # macOS/Linux
venv\Scripts\activate           # Windows
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Add data files
Download the LendingClub datasets and place them in the `data/` folder:
- `loan_data_2007_2014.csv` — Development set
- `loan_data_2015.csv` — Out-of-time (OOT) validation set

> ⚠️ Data files are excluded from Git (see `.gitignore`) due to size. Download from [Kaggle — LendingClub](https://www.kaggle.com/datasets/wordsforthewise/lending-club).

### 5. Run the notebook
```bash
jupyter notebook notebooks/IFRS9_LendingClub_CreditRisk.ipynb
```

Or run headlessly:
```bash
bash scripts/run_notebook.sh
```

---

## 📊 Key Results

| Model | Metric | Value |
|-------|--------|-------|
| Logistic Regression (PD) | AUC-ROC | ~0.70+ |
| XGBoost (PD Challenger) | AUC-ROC | ~0.72+ |
| Beta Regression (LGD) | RMSE | ~0.20 |
| Beta Regression (EAD) | RMSE | ~0.05 |

> Exact values will vary depending on your data version and random seed.

---

## 🐛 Known Issues & Fixes

### KeyError: `['total_rec_prncp'] not in index`
**Root cause:** `total_rec_prncp` and `recoveries` are dropped in Cell 4 (`drop_cols`) before Cell 7 tries to use them to build targets.

**Fix applied:** Target columns are now saved into `target_raw` and `target_raw_oot` at the **top of Cell 4**, before any columns are dropped.

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgements

- [LendingClub](https://www.lendingclub.com/) for the public loan dataset
- IASB IFRS 9 Financial Instruments standard
- Federal Reserve SR 11-7 Model Risk Management guidance
