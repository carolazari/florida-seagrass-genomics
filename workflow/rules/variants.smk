rule bcftools_call:
    input:
        bamlist="results/bam/bamlist.txt",
        ref=config["reference"]["fasta"]
    output:
        "results/vcf/raw.vcf.gz"
    threads: 16
    resources:
        mem_mb=32000,
        runtime=480
    conda:
        "../envs/bcftools.yaml"
    shell:
        """
        bcftools mpileup -f {input.ref} -b {input.bamlist} -Ou | \
        bcftools call -mv -Oz -o {output}
        """



