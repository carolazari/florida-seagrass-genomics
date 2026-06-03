rule fastp:
    input:
        r1="raw/{sample}_R1.fastq.gz",
        r2="raw/{sample}_R2.fastq.gz"
    output:
        r1="results/qc/{sample}_R1.fq.gz",
        r2="results/qc/{sample}_R2.fq.gz"
    threads: 4
    conda:
        "../envs/fastp.yaml"
    shell:
        """
        fastp -i {input.r1} -I {input.r2} \
              -o {output.r1} -O {output.r2}
        """
