rule generateBackground:
    input: 
        'data/promoters_{sample}.fa'
    output:
        temp('data/background_{sample}.txt')
    singularity:
        'workflow/envs/InCURA.sif'
    shell:
        """
        export PATH=$HOME/meme/bin:$HOME/meme/libexec/meme-5.5.7:$PATH
        fasta-get-markov < {input} > {output}
        """

rule runFIMO:
    input:
        background='data/background_{sample}.txt',
        motifs='data/motifs.meme',
        promoters='data/promoters_{sample}.fa'
    output:
        'data/fimo_{sample}/fimo.tsv'
    singularity:
        'workflow/envs/InCURA.sif'
    threads: 32
    shell:
        """
        fimo --oc data/fimo_{wildcards.sample} --verbosity 2 --thresh 2e-5 --bgfile {input.background} {input.motifs} {input.promoters}
        """