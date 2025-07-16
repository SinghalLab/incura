
ORGANISM = config['organism']
print(ORGANISM)


#-----------------------------------------------------------


rule downloadTFs:
    output:
        tfs='data/all_TFs.txt'
    params:
        TFs=config['data']['url'][ORGANISM]['TFs']
    singularity:
        'workflow/envs/InCURA.sif'
    shell:
        """
        wget '{params.TFs}' -O '{output.tfs}'
        """

rule downloadGenome:
    output:
        genome='data/genome.fa',
        annot='data/annot.gtf'
    params:
        genome=config['data']['url'][ORGANISM]['genome'],
        annot=config['data']['url'][ORGANISM]['annot'],
        gzip_genome='data/genome.fa.gz',
        gzip_annot='data/annot.gtf.gz'
    singularity:
        'workflow/envs/InCURA.sif'
    shell:
        """
        wget '{params.genome}' -O '{params.gzip_genome}'
        wget '{params.annot}' -O '{params.gzip_annot}'

        gunzip '{params.gzip_genome}'
        gunzip '{params.gzip_annot}'
        """

    
    
