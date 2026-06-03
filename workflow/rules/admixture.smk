rule admixture:
    input:
        "results/plink/pca.bed"
    output:
        "results/admixture/K{K}.Q"
    conda:
        "../envs/admixture.yaml"
    shell:
        """
        admixture --cv results/plink/pca.bed {wildcards.K} | \
        tee results/admixture/K{wildcards.K}.log
        """
