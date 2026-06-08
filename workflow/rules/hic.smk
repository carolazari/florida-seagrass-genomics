rule hic_map:
    input:
        ref="results/assembly/halodule.contigs.fa",
        r1=config["assembly"]["hic_r1"],
        r2=config["assembly"]["hic_r2"]

    output:
        "results/hic/halodule.bam"

    threads: 16

    conda:
        "../envs/bwa.yaml"

    shell:
        """
        bwa mem -5SP -t {threads} {input.ref} {input.r1} {input.r2} | samtools view -bS - > {output}

        """

rule hic_sort:
    input:
        "results/hic/halodule.bam"

    output:
        "results/hic/halodule.sorted.bam"

    conda:
        "../envs/samtool.yaml"

    shell:
        "samtools sort -o {output} {input}"


rule hic_index:
    input:
        "results/hic/halodule.sorted.bam"

    output:
        "results/hic/halodule.sorted.bam.bai"

    conda:
        "../envs/samtools.yaml"

    shell:
        "samtools index {input}"            