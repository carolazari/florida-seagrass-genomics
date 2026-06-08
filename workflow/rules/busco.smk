rule busco:
    input: 
        "results/assembly/halodule.primary.fa"

    output:
        directory:"results/assembly/busco")

    threads: 32

    resources: 
        mem_mb=128000,
        runtime=1440

    conda:
        "envs/busco.yaml"

    shell:
        """
        busco -i {input} -m genome -l {config[assembly][busco_lineage]} -o halodule_busco --out_path results/assembly 

        """

rule assembly_complete:
    input:
        "results/assembly/haludore.primary.fa",
        directory("results/assembly/busco")

    output:
        touch("results/assembly/ASSSEMBLY_COMPLETE")                            