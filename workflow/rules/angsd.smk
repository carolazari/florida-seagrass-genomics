rule angsd_beagle:
    input:
        bamlist="results/bam/bamlist.txt",
        ref=config["reference"]["fasta"]
    output:
        "results/angsd/pop.beagle.gz"
    threads: 16
    resources:
        mem_mb=32000,
        runtime=480
    conda:
        "../envs/angsd.yaml"
    shell:
        """
        angsd -b {input.bamlist} -ref {input.ref} \
              -GL {config[angsd][gl_model]} \
              -doGlf 2 -doMajorMinor 1 -doMaf 1 \
              -minMapQ {config[angsd][minMapQ]} \
              -minQ {config[angsd][minQ]} \
              -out results/angsd/pop \
              -P {threads}
        """

