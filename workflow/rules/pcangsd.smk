rule pcangsd:
    input:
        "results/angsd/pop.beagle.gz"
    output:
        "results/pcangsd/pca.npy"
    threads: 16
    conda:
        "../envs/pcangsd.yaml"
    shell:
        """
        pcangsd -beagle {input} -o results/pcangsd/pca -threads {threads}
        """
