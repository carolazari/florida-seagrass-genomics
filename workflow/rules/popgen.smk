# PopGen Rules: Maps population RADseq data to the assembly

rule run_angsd:
    input: bam_list = f"{config['output_dir']}/popgen/bams/bam_list.txt"
    output: beagle = f"{config['output_dir']}/popgen/angsd/seagrass_gls.beagle.gz"

    threads: 8

    resources:
        partition = "shortq7",
        time = "05:00:00",      # Give it 5 hours to scan all individuals
        mem_mb = 32000          # 32GB RAM

    log: "logs/popgen/angsd.log"

    shell:
        "angsd -bam {input.bam_list} -GL 2 -doGlf 2 -doMajorMinor 1 -doMaf 1 "
        "-SNP_pval {config['snp_pval']} -minMapQ {config['minMapQ']} -minQ {config['minQ']} "
        "-minMaf {config['minMaf']} -minInd {config['minInd']} -nThreads {threads} -out {config['output_dir']}/popgen/angsd/seagrass_gls &> {log}"
