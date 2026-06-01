#==== Reference Genome Assembly=====
#==== Reference Genome Assembly=====

rule assemble_genome:
    input:
        reads = config["wgs_reads"]
    output:
        contigs = f"{config['output_dir']}/assembly/megahit_out/final.contigs.fa"
    threads: 16
    resources:
        partition = "mediumq7",  # Megahit requires Athene's medium queue
        time = "24:00:00",
        mem_mb = 64000
    log: "logs/assembly/megahit.log"
    shell:
        "megahit -r {input.reads} -t {threads} -o {config[output_dir]}/assembly/megahit_out --force &> {log}"

rule clean_headers:
    input: 
        raw_fasta = f"{config['output_dir']}/assembly/megahit_out/final.contigs.fa"
    output: 
        clean_fasta = config["ref_genome_path"] # Pulls perfectly from config.yaml
    resources:
        partition = "shortq7",
        time = "00:15:00",
        mem_mb = 4000
    shell:
        "awk '/^>/{print \">FL_Seagrass_Contig_\"++i;next}{print}' {input.raw_fasta} > {output.clean_fasta}"
