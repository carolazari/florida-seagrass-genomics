rule yahs:
    input:
        ref="results/assembly/halodule.contigs.fa",
        bam="results/hic/{sample}.sorted.bam"

    output:
        "results/assembly/halodule.chromosome.fa"

    threads: 32

    conda:
        "../envs/yahs.yaml"

    shell:
        """
        yahs {input.ref} {input.bam} -o results/assembly/halodule

        """            