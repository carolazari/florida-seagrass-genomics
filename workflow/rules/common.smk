import os
import pandas as pd
from snakemake.utils import validate

# 1. Handle data parent prefixes 
data_prefix = ""
data_parent_key = "data_parent_dir"

if data_parent_key in config:
    if config[data_parent_key] and not config[data_parent_key].endswith("/"):
        raise ValueError(f"Error: '{data_parent_key}' must end with a trailing forward slash.")
    data_prefix = config[data_parent_key]

# 2. Open the units sheet and explicitly enforce string formatting on indexes

units_df = pd.read_table(config["units"], dtype=str).set_index("sample", drop=False)
units_df.index = [str(i) for i in units_df.index]

# 3. Derive sample lists directly from the table (skipping independent sample.tsv sheets)

SAMPLES = list(units_df["sample"].unique())

# 4. Eric's Dynamic File Picker (Safely extracts input paths using wildcards)

def get_fastq(wildcards):
    """Get dynamic fastq file path based on the validated units layout."""
    fastqs = units_df.loc[wildcards.sample, "fq1"]
    return data_prefix + fastqs

# 5. Global Wildcard Constraints ( tool to prevent Snakemake path confusion)

wildcard_constraints:
    sample="|".join(SAMPLES),
    k="|".join([str(x) for x in config["admixture"]["k_values"]])

# 6. Cluster Environment Preparation
os.makedirs("logs/slurm", exist_ok=True)
