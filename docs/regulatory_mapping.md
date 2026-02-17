# Regulatory Mapping — IFRS 9 / Basel III / SR 11-7 / SS3/18

| Standard | Article / Clause | Notebook Cell | Code Object | Description |
|----------|-----------------|---------------|-------------|-------------|
| IFRS 9 §5.5.1 | ECL recognition | Cell 28 | `df['ecl_final']` | 12-month and lifetime ECL computation |
| IFRS 9 §5.5.9 | SICR trigger | Cell 28 | `assign_stage()` | Stage 1/2/3 allocation based on PD threshold |
| IFRS 9 §B5.5.28 | Forward-looking info | Cells 18, 24 | PD models | Point-in-time PD estimation |
| IFRS 9 §B5.5.37 | Credit-impaired definition | Cell 7 | `default_flag` | Charged Off / Default / Late / Grace |
| Basel III Art.160 | IRB PD floor ≥ 0.03% | Cell 27 | `calibrate_pd()` | Regulatory floor applied post-calibration |
| Basel III Art.161 | Downturn LGD | Cell 27 | `calibrate_lgd()` | Economic stress add-on to LGD estimates |
| Basel III Art.166 | EAD on-balance-sheet | Cell 22 | `ead_model` | EAD ratio via Beta regression |
| SR 11-7 §III | Model development & documentation | Cells 3–17 | All preprocessing | Data quality, feature engineering, selection |
| SR 11-7 §IV | Independent validation | Cells 19, 25–26 | `evaluate_pd_model()` | AUC, KS, Gini, confusion matrix |
| SR 11-7 §V | Champion/Challenger governance | Cell 26 | `comparison_df` | LR vs XGBoost comparison |
| SR 11-7 §VI | Ongoing monitoring | Cell 30 | `rag_dashboard()` | PSI, AUC drift, RAG thresholds |
| SS3/18 §3 | Model design expectations | Cells 18–23 | All models | LR, XGBoost, Beta regression |
| SS3/18 §7 | Stress testing | Cell 28 | `ecl_stress()` | PD × stress multiplier scenario |
| SS3/18 §11 | Model limitations register | Cell 32 | Markdown | Documented assumptions & gaps |
| BCBS 239 | Risk data aggregation | Cells 4–5 | `data_quality_report()` | Completeness, accuracy, timeliness |
