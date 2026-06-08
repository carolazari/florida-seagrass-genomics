rule busco:
    input: 
        "results/assembly/halodule.primary.fa"

    output:
        directory("results/assembly/busco")

    threads: 32

    resources: 
        mem_mb=128000,
        runtime=1440

    conda:
        "envs/busco.yaml"

    shell:
        """
        busco -i {input} -m genome -l {config[assembly][busco_lineage]} -o busco --out_path results/assembly 

        """

rule assembly_complete:
    input:
        fasta="results/assembly/halodule.primary.fa",
        busco="results/assembly/busco/short_summary*.txt",
        scaffold="results/assembly/halodule.chromosome.fa"

    output:
        touch("results/assembly/ASSEMBLY_COMPLETE")                            