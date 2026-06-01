# ====run_popgen: RADseq Population Genomics Module=====

rule index_reference:
    input:
        ref = config["ref_genome_path"]
    output:
        bwt = f"{config['ref_genome_path']}.bwt"
    resources:
        partition = "shortq7",
        time = "00:30:00",
        mem_mb = 4000
    shell:
        "bwa index {input.ref}"

rule align_radseq:
    input:
        ref = config["ref_genome_path"],
        bwt = f"{config['ref_genome_path']}.bwt",
        
        reads = get_fastq
    output:
        bam = f"{config['output_dir']}/popgen/bams/{{sample}}.sorted.bam"
    threads: 4
    resources:
        partition = "shortq7",
        time = "02:00:00",
        mem_mb = 8000
    shell:
        "bwa mem -t {threads} {input.ref} {input.reads} | samtools view -Sb - | samtools sort -o {output.bam} -"

rule create_bam_list:
    input:
        bams = expand(f"{config['output_dir']}/popgen/bams/{{sample}}.sorted.bam", sample=SAMPLES)
    output:
        bam_list = f"{config['output_dir']}/popgen/bams/bam_list.txt"
    resources:
        partition = "shortq7",
        time = "00:05:00",
        mem_mb = 1000
    run:
        with open(output.bam_list, "w") as f:
            for b in input.bams:
                f.write(f"{b}\n")

rule run_angsd:
    input:
        bam_list = f"{config['output_dir']}/popgen/bams/bam_list.txt"
    output:
        beagle = f"{config['output_dir']}/popgen/angsd/seagrass_gls.beagle.gz"
    threads: 8
    resources:
        partition = "shortq7",
        time = "05:00:00",
        mem_mb = 32000
    log: "logs/popgen/angsd.log"
    shell:
        """
        angsd -bam {input.bam_list} -GL 2 -doGlf 2 -doMajorMinor 1 -doMaf 1 \
            -SNP_pval {config[angsd_params][snp_pval]} \
            -minMapQ {config[angsd_params][minMapQ]} \
            -minQ {config[angsd_params][minQ]} \
            -minMaf {config[angsd_params][minMaf]} \
            -minInd {config[angsd_params][minInd]} \
            -nThreads {threads} \
            -out {config[output_dir]}/popgen/angsd/seagrass_gls &> {log}
        """

rule run_pcangsd:
    input:
        beagle = f"{config['output_dir']}/popgen/angsd/seagrass_gls.beagle.gz"
    output:
        cov = config["pca_output_path"]
    threads: 4
    resources:
        partition = "shortq7",
        time = "01:00:00",
        mem_mb = 16000
    shell:
        "pcangsd -beagle {input.beagle} -threads {threads} -o {config[output_dir]}/popgen/pcangsd/seagrass_pca"

rule run_ngsadmix:
    input:
        beagle = f"{config['output_dir']}/popgen/angsd/seagrass_gls.beagle.gz"
    output:
        qopt = f"{config['output_dir']}/popgen/ngsadmix/k{{k}}_admix.qopt"
    threads: 4
    resources:
        partition = "shortq7",
        time = "03:00:00",
        mem_mb = 16000
    shell:
        "NGSadmix -likes {input.beagle} -K {wildcards.k} -P {threads} -o {config[output_dir]}/popgen/ngsadmix/k{wildcards.k}_admix"
