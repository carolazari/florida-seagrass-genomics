#rule assembly_placeholder:
#    output:
#        "results/assembly/NOT_RUN.txt"
#    shell:
#        """
#        echo "Assembly module disabled until sequencing technology is known" > {output}
#        """

include: "rules/hifiasm.smk"
include: "rules/busco.smk"