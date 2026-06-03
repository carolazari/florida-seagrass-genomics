rule ngsadmix:
    input:
        "results/angsd/pop.beagle.gz"
    output:
        "results/ngsadmix/K{K}.qopt"
    threads: 16
    conda:
        "../envs/ngsadmix.yaml"
    shell:
        """
        NGSadmix -likes {input} -K {wildcards.K} -P {threads} \
                 -o results/ngsadmix/K{wildcards.K}
        """
