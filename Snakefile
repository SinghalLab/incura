from snakemake.utils import min_version

min_version('7.14.0')

configfile: 'config/config.yaml'
#container: 'workflow/envs/incura.sif'

ORGANISM = config['organism']

# Read the list of input files from a text file
#with open("data/output_files.txt") as f:
 #   input_files = [line.strip() for line in f]


rule all:
    input: 
        'data/fimo_SLE/fimo.tsv'

#------------------------------------------------------------------------------------
module getData:
    snakefile: "rules/getData.smk"
    config: config

use rule * from getData

module getMotifs:
    snakefile: "rules/getMotifs.smk"
    config: config

use rule * from getMotifs

module getPromoters:
    snakefile: "rules/getPromoters.smk"
    config: config

use rule * from getPromoters

module runFIMO:
    snakefile: "rules/runFIMO.smk"
    config: config

use rule * from runFIMO


# snakemake --profile config/slurm/ ...