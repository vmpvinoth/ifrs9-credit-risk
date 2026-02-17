# Data

This folder holds the LendingClub datasets required to run the notebook.

## Required Files

| File | Description | Rows (approx) |
|------|-------------|---------------|
| `loan_data_2007_2014.csv` | Development dataset | ~466,000 |
| `loan_data_2015.csv` | Out-of-time (OOT/PSI) dataset | ~421,000 |

## Download

Both files are available from Kaggle:

👉 https://www.kaggle.com/datasets/wordsforthewise/lending-club

Download and place the CSV files directly in this `data/` folder.

## Note

These files are excluded from Git tracking via `.gitignore` due to their size (~300MB+).
Never commit raw data files to GitHub.
