#!/bin/bash
# ── run_notebook.sh ───────────────────────────────────────────────────────────
# Executes the IFRS 9 notebook headlessly and saves output with results.
# Usage: bash scripts/run_notebook.sh
# ─────────────────────────────────────────────────────────────────────────────

set -e  # Exit on error

NOTEBOOK="notebooks/IFRS9_LendingClub_CreditRisk.ipynb"
OUTPUT="notebooks/IFRS9_LendingClub_CreditRisk_executed.ipynb"
LOGFILE="outputs/run_$(date +%Y%m%d_%H%M%S).log"

echo "========================================"
echo " IFRS 9 Credit Risk — Notebook Runner"
echo "========================================"
echo "Input  : $NOTEBOOK"
echo "Output : $OUTPUT"
echo "Log    : $LOGFILE"
echo ""

# Check data files exist
if [ ! -f "data/loan_data_2007_2014.csv" ]; then
    echo "❌ ERROR: data/loan_data_2007_2014.csv not found."
    echo "   Download from: https://www.kaggle.com/datasets/wordsforthewise/lending-club"
    exit 1
fi

if [ ! -f "data/loan_data_2015.csv" ]; then
    echo "❌ ERROR: data/loan_data_2015.csv not found."
    exit 1
fi

echo "✅ Data files found."
echo "🚀 Running notebook (this may take 10–20 minutes)..."
echo ""

jupyter nbconvert \
    --to notebook \
    --execute \
    --ExecutePreprocessor.timeout=3600 \
    --ExecutePreprocessor.kernel_name=python3 \
    --output "$OUTPUT" \
    "$NOTEBOOK" 2>&1 | tee "$LOGFILE"

echo ""
echo "========================================"
echo "✅ Notebook executed successfully."
echo "   Saved to : $OUTPUT"
echo "   Log      : $LOGFILE"
echo "========================================"
