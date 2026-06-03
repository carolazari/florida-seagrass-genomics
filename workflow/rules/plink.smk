rule plink_pca:
    input:
        "results/vcf/raw.vcf.gz"
    output:
        "results/plink/pca.eigenvec"
    conda:
        "../envs/plink.yaml"
    shell:
        """
        plink --vcf {input} --pca --make-bed \
              --out results/plink/pca
        """
