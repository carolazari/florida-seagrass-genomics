rule bwa_index:
    input:
        config["reference"]["fasta"]
    conda:
        "../envs/bwa.yaml"
    shell:
        "bwa index {input}"


rule bwa_mem:
    input:
        r1="results/qc/{sample}_R1.fq.gz",
        r2="results/qc/{sample}_R2.fq.gz",
        ref=config["reference"]["fasta"]
    output:
        "results/bam/{sample}.bam"
    threads: 8
    conda:
        "../envs/bwa.yaml"
    shell:
        """
        bwa mem -t {threads} {input.ref} {input.r1} {input.r2} | \
        samtools view -bS - > {output}
        """

