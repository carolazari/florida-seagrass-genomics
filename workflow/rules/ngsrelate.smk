rule ngsrelate:
    input:
        "results/angsd/pop.beagle.gz"
    output:
        "results/ngsrelate/rel.txt"
    conda:
        "../envs/ngsrelate.yaml"
    shell:
        "NGSrelate -g {input} -O {output}"



