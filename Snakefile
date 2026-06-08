configfile: "config/config.yaml"

import pandas as pd

SAMPLES = pd.read_csv(config["samples"], sep="\t")["sample_id"].tolist()

include: "rules/qc.smk"
include: "rules/mapping.smk"
include: "rules/bam_processing.smk"
include: "rules/assembly.smk"
include: "rules/angsd.smk"
include: "rules/pcangsd.smk"
include: "rules/ngsadmix.smk"
include: "rules/ngsrelate.smk"
include: "rules/variants.smk"
include: "rules/plink.smk"
include: "rules/admixture.smk"
include: "rules/assembly.smk"
include: "rules/hifiasm.smk"
include: "rules/hic.smk"
include: "rules/scaffolding.smk"


rule all:
    input:
        "results/report/final.done"
        "results/assembly/ASSEMBLY_COMPLETE"
