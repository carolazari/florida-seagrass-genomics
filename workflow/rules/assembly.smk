# Assembly Rules: Only deals with the single WGS individual

rule assemble_genome:
    input:
        reads = config["wgs_reads"]
    output:
        contigs = f"{config['output_dir']}/assembly/megahit_out/final.contigs.fa"

    threads: 16

    resources:
        partition = "mediumq7",  # Megahit can take a while; upgrade from shortq7 to mediumq7 (max 3 days)
        time = "24:00:00",       # Ask for 24 hours of cluster computing time
        mem_mb = 64000           # Ask for 64GB of RAM to hold assembly strings
    log: "logs/assembly/megahit.log"
    shell:
        "megahit -r {input.reads} -t {threads} -o {config['output_dir']}/assembly/megahit_out --force &> {log}"

rule clean_headers:
    input: raw_fasta = f"{config['output_dir']}/assembly/megahit_out/final.contigs.fa"
    output: clean_fasta = f"{config['output_dir']}/assembly/final_genome.fasta"

    resources:
        partition = "shortq7",   # Quick text manipulation task; keep it in the short queue
        time = "00:15:00",       # 15 minutes is plenty
        mem_mb = 4000            # 4GB RAM
    shell:
        "awk '/^>/{print \">FL_Seagrass_Contig_\"++i;next}{print}' {input.raw_fasta} > {output.clean_fasta}"
