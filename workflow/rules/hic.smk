rule hic_map:
    input:
        ref="results/assembly/halodule.contigs.fa",
        r1="raw_hic/{sample}_R1.fastq.gz",
        r2="raw_hic/{sample}_R2.fastq.gz"

    output:
        "results/hic/{sample}.bam"

    threads: 16

    conda:
        "../envs/bwa.yaml"

    shell:
        """
        bwa mem -55P -t {threads} {input.ref} {input.r1} {input.r2} | samtools view -bS - > {output}

        """

rule hic_sort:
    input:
        "results/hic/{sample}.bam"

    output:
        "results/hic/{sample}sorted.bam"

    conda:
        "../envs/samtool.yaml"

    shell:
        "samtools sort -o {output} {input}"


rule hic_index:
    input:
        "results/hic/{sample}.sorted.bam"

    output:
        "result/hic/{sample}.sorted.bam.bai"

    conda:
        "../envs/samtools.yaml"

    shell:
        "samtools index {input}"            