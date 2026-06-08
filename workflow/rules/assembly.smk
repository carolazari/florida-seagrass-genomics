#rule assembly_placeholder:
#    output:
#        "results/assembly/NOT_RUN.txt"
#    shell:
#        """
#        echo "Assembly module disabled until sequencing technology is known" > {output}
#        """

include: "hifiasm.smk"
include: "busco.smk"