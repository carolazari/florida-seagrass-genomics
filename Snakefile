configfile: "config/config.yaml"

import pandas as pd

#SAMPLES = pd.read_csv(config["samples"], sep="\t")["sample_id"].tolist()

import pandas as pd

SAMPLES = []

if config.get("samples"):
    SAMPLES = pd.read_csv(config["samples"], sep="\t")["sample_id"].tolist()

include: "workflow/rules/qc.smk"
include: "workflow/rules/mapping.smk"
include: "workflow/rules/bam_processing.smk"
include: "workflow/rules/assembly.smk"
include: "workflow/rules/angsd.smk"
include: "workflow/rules/pcangsd.smk"
include: "workflow/rules/ngsadmix.smk"
include: "workflow/rules/ngsrelate.smk"
include: "workflow/rules/variants.smk"
include: "workflow/rules/plink.smk"
include: "workflow/rules/admixture.smk"
include: "workflow/rules/assembly.smk"
include: "workflow/rules/hifiasm.smk"
include: "workflow/rules/hic.smk"
include: "workflow/rules/scaffolding.smk"


rule all:
    input:
        "results/report/final.done"
        "results/assembly/ASSEMBLY_COMPLETE"
