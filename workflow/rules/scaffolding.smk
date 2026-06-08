rule yahs:
    input:
        ref="results/assembly/halodule.contigs.fa",
        bam="results/hic/{sample}.sorted.bam"

    output:
        "results/assembly/halodule.scaffolds.fa"

    threads: 32

    conda:
        "../envs/yahs.yaml"

    shell:
        """
        yahs {input.ref} {input.bam} -o results/assembly/halodule

        """            

rule make_chromosomes:
    input:
        "results/assembly/halodule.scaffolds.fa"

    output:
        "results/assembly/halodule.chromosome.fa"

    shell:
        """
        cp {input} {output}
        """        