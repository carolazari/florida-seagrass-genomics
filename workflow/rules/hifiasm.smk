rule pacbio_to_fastq:
    input:
        config["assembly"]["pacbio_bam"]

    output:
        "results/assembly/hifi_reads.fastq.gz"

    threads: 16

    resources:
        mem_mb=64000,
        time="05:00:00"

    conda:
        "../envs/samtools.yaml"

    shell:
        """
        samtools fastq {input} | gzip > {output}

        """

rule hifiasm:
    input:
        "results/assembly/hifi_reads.fastq.gz"

    output:
        "results/assembly/halodule.bp.p_ctg.gfa"

    threads: 64    

    resources:
        mem_mb=512000,
        time="05:00:00"    

    conda:
        "../envs/hifiasm.yaml"

    shell:
        """
        hifiasm -o results/assembly/halodule -t {threads} {input}

        """

rule gfa_to_fasta:
    input:
        "results/assembly/halodule.bp.p_ctg.gfa"

    output:
        "results/assembly/halodule.contigs.fa"

    shell:
        r'''
        awk '/^S/ {{print ">"$2"\n"$3}}' {input} > {output}

        '''



