# Projeto 7 - Pipeline de Engenharia Analítica com Python, Docker, DBT, BigQuery e Looker Studio

with
    dim_produtos as (
        select
            produto_id AS id_produto,
            nome_produto AS nome_produto,
            categoria AS categoria_produto,
            preco AS preco_produto
        from
            {{ source('dsastaging', 'stg_produtos') }}
    )

select * from dim_produtos
