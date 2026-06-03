rule sort_bam:
    input:
        "results/bam/{sample}.bam"
    output:
        "results/bam/{sample}.sorted.bam"
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools sort -o {output} {input}"


rule index_bam:
    input:
        "results/bam/{sample}.sorted.bam"
    output:
        "results/bam/{sample}.sorted.bam.bai"
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools index {input}"
