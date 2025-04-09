# Pipeline de Engenharia Analítica com Python, Docker, DBT, BigQuery e Looker Studio

Este projeto desenvolve um pipeline de engenharia analítica moderno e automatizado, voltado para transformar dados brutos em insights acessíveis e confiáveis para o negócio. Utilizando tecnologias como Python, Docker, DBT e Google BigQuery, a solução permite centralizar, organizar e transformar grandes volumes de dados de forma escalável. 

A arquitetura foi pensada para facilitar a governança, garantindo segurança no acesso aos dados com autenticação via conta de serviço do Google Cloud. Após o tratamento, os dados ficam prontos para serem visualizados no Looker Studio, permitindo que áreas de negócio acompanhem indicadores com agilidade e precisão. Todo o processo é documentado e versionado, garantindo rastreabilidade e facilitando a manutenção e evolução da solução.

<img src="https://i.imgur.com/gcHNUFQ.png" style="width:100%;height:auto"/>

Tecnologias:
* Python
* SQL
* Docker
* DBT
* Google Big query
* IaC

## Criação do arquivo de credenciais JSON de acesso a projeto do Big Query pelo IAM

1. Acesse o Google Cloud Console
2. IAM & Admin → Service Accounts (Ou direto: https://console.cloud.google.com/iam-admin/serviceaccounts)
3. Clique em "Create Service Account" (Nome: pode ser algo como bigquery-python) ID: será preenchido automaticamente
4. Clique em "Create and Continue"
5. Dê a permissão necessária para acessar o BigQuery: (Exemplo: BigQuery Admin, se quiser acesso total)
6. Siga até o final e clique em "Done"
7. Agora clique na conta criada → vá em "Keys" → clique em "Add Key" → "Create new key" (Tipo: JSON)
8. Clique em Create para baixar um arquivo .json automaticamente

```
# Caminho do JSON de credencial
key_path = "/dsa/chave/nomedoprojeto-f8e1375ec20f.json"
```

## Configuração da máquina cliente

O Dockerfile possui uma imagem linux que já traz o interpretador do python:
``` FROM python:3.11-slim ```

1. Crie a imagem Docker. Abra um terminal ou prompt de comando, navegue até a pasta onde estão os arquivos e execute:



``` docker build -t dbt-image:projeto7 . ```

2. Crie o container

``` docker run -dit --name dsa-dbt-projeto7 -p 8080:8080 -v ./dsa:/dsa dbt-image:projeto7 ```

NOTA: No Windows você deve substituir ./dsa pelo caminho completo da pasta, por exemplo: C:\DSA\Cap15\dsa

3. Criando um projeto DBT e fazendo a configuração pelo terminal docker

Aqui são geradas todas as pastas com os modelos DBT

``` dbt init projeto7 ```

* Which database would you like to use? [1] bigquery
* Desired authentication method option:[2] service_account
* keyfile (/path/to/bigquery/keyflle.json): /dsa/chave/nomedoprojeto-f8e1375ec20f.json
* project (GCP project id): nomedoprojetobigquery
* dataset (the name of your dbt dataset): dsadwp7
* Threads: [1]
* Location: [US]

4. Verifique a pasta criada com todos os artefatos

5. Acesse a pasta e execute o debug para testar a configuração (Validar conexão entre DBT e Big query)

```
cd /dsa/projeto
dbt debug
```
Copie os arquivos para as respectivas pastas

## Fazendo a Carga de dados CSV para as tabelas no Dataset do Projeto Big query

``` dsa_carrega_dados_bigquery.py ```

Este arquivo Python:

* Se conecta com o projeto do Bigquery
* Criar o dataset (banco de dados) se ele não existir
* Carregar cada CSV como uma tabela no BigQuery

## Configuração do DBT

Diretório:  
> project_course_pipeline_elt_dbt_bigquery/arquivos_p7/models/staging/

* Arquivos SQL: Fazem a transformação das tabelas da área de staging para
* Arquivos YML: Documentação DBT e linhagem dos dados

Deploy dos modelos

``` dbt run ```

Limpar e recriar os modelos do zero

``` dbt run --full-refresh ```

Target em produção

``` dbt run --target prod ```

## Gerando arquivo de catálogo da Documentação e Data Lineage

```
dbt docs generate
dbt docs serve --host 0.0.0.0 --port 8080
```

<img src="https://i.imgur.com/fUwkSpu.png" style="width:100%;height:auto"/>
<img src="https://i.imgur.com/wio9y9l.png" style="width:100%;height:auto"/>






