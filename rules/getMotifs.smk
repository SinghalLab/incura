rule getExpressedTFs:
    input:
        all_TFs='data/all_TFs.txt',
        expr_genes='data/genes.txt'
    output: #flag as temp output once tested
        expr_TFs='data/expr_TFs.txt'
    shell:
        """
        grep -w -f {input.expr_genes} {input.all_TFs} > {output.expr_TFs}
        """


rule extractMotifs:
    input:
        TFs='data/expr_TFs.txt'
    output:
        memeMotifs='data/motifs.meme'
    singularity:
        'workflow/envs/InCURA.sif'
    params:
        organism=config['organism']
    shell:
        """
        Rscript workflow/scripts/getMotifs.R \
        {input.TFs} \
        {params.organism} \
        {output}
        """