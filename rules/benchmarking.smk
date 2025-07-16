rule getKnockTF:
    output:
        knockTF_expr='data/knockTF_expr.csv',
        knockTF_meta='data/knockTF_meta.csv'
    params: 
        expr=config['data']['url'][ORGANISM]['knockTF_expr'],
        meta=config['data']['url'][ORGANISM]['knockTF_meta'],
    shell:
        """
        wget '{params.expr}' -O '{output.knockTF_expr}'
        wget '{params.meta}' -O '{output.knockTF_meta}'
        """