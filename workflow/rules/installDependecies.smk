
rule installMEME:
    output:
        index='software/meme-5.5.7.tar.gz'
    params:
        meme=config['software']['url']['meme']
    singularity:
        'workflow/envs/InCURA.sif'
    shell:
        """
        wget '{params.meme}' -O '{output.index}'
        tar zxf {output.index}
        (cd software/meme-5.5.7 && ./configure --prefix=$HOME/meme --enable-build-libxml2 --enable-build-libxslt && make && make test && make install)
        """
