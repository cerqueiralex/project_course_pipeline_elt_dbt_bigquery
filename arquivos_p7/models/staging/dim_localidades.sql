# Projeto 7 - Pipeline de Engenharia Analítica com Python, Docker, DBT, BigQuery e Looker Studio

with
    dim_localidades as (
        select
            localidade_id AS id_localidade,
            cidade AS cidade_localidade,
            estado AS estado_localidade,
            pais AS pais_localidade,
            cep AS cep_localidade
        from
            {{ source('dsastaging', 'stg_localidades') }}
    )

select * from dim_localidades
