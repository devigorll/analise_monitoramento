# 🚚 Monitoramento Logístico: Rastreamento e Inteligência Operacional

![Status do Projeto](https://img.shields.io/badge/Status-Em%20Desenvolvimento-orange)
![Linguagem](https://img.shields.io/badge/Language-Python-blue)
![Banco de Dados](https://img.shields.io/badge/Database-SQL%20Server-red)
![BI](https://img.shields.io/badge/BI-Power%20BI-yellow)

Este projeto simula uma operação logística ponta a ponta. Ele abrange desde a modelagem de um banco de dados relacional no **SQL Server** até a ingestão de dados sintéticos via **Python (Faker)**, engenharia de dados com views estruturadas, análise exploratória (EDA) e criação de dashboards táticos no **Power BI**.

O objetivo é responder a perguntas estratégicas de negócio, como gargalos de entrega, eficiência da frota, receitas de frete e performance dos Centros de Distribuição (CDs).

---

## 📌 Conteúdo do Projeto

* **Modelagem de Dados Relacional**: Tabelas de dimensões e fatos estruturadas para suportar consultas analíticas rápidas.
* **Geração de Dados Realistas (ETL)**: Pipeline em Python utilizando a biblioteca `Faker` para simular milhares de registros consistentes.
* **Camada de Visões (SQL Views)**: Criação de views analíticas no SQL Server para simplificar e otimizar o consumo dos dados pelas ferramentas de visualização.
* **Análise Exploratória (EDA)**: Investigação de métricas de distribuição de carga, tempos de entrega e faturamento via Pandas, Seaborn e Matplotlib.
* **Dashboard de Performance**: Painel interativo para acompanhamento de KPIs logísticos e financeiros.

---

## 🗄️ Estrutura do Banco de Dados

A arquitetura do banco foi desenhada para rastrear o ciclo de vida de cada envio, associando-o ao veículo correspondente e registrando todo o histórico de transições de status nos hubs.

| Tabela | Tipo | Descrição |
| :--- | :--- | :--- |
| **`clientes`** | Dimensão | Dados cadastrais e localização geográfica dos clientes. |
| **`veiculos`** | Dimensão | Cadastro da frota, controle de placas e capacidade em kg. |
| **`centros_distribuicao`** | Dimensão | Identificação e localização dos hubs logísticos. |
| **`produtos` / `faixas_peso`** | Dimensão | Classificação dos itens transportados por categoria e faixas de peso. |
| **`status_entrega`** | Dimensão | Tabela de domínio contendo os possíveis status de uma entrega. |
| **`fato_envios`** | Fato | Registro principal da carga, datas do ciclo de envio e valor do frete. |
| **`itens_envio`** | Fato/Ponte | Detalhamento dos produtos contidos em cada envio (quantidade e valores). |
| **`fato_status_entrega`** | Fato | Histórico temporal do rastreamento de cada envio pelos CDs. |

---

## 📁 Estrutura do Repositório
```
MONITORAMENTO_LOGISTICO/
├── dashboards/
│   ├── app.py                      # Aplicação complementar de suporte ao projeto
│   └── dashboard.pbix              # Arquivo de desenvolvimento do Dashboard no Power BI
├── data/                           # Bases de dados extraídas e exportações do pipeline
│   ├── metricas_basicas.csv
│   ├── qtd_envio_por_cliente.csv
│   ├── qtd_envio_por_veiculo.csv
│   ├── qtd_recebido_por_cd.csv
│   ├── vw_envio.csv
│   └── vw_produtos.csv
├── documentos/
│   └── img/                        # Assets e ícones utilizados na documentação e dashboards
├── notebooks/
│   ├── 01_populando_faker.ipynb    # Notebook focado na geração e inserção de dados sintéticos
│   └── 02_analise_exploratoria.ipynb  # Análise estatística e descoberta de insights (EDA)
├── scripts/                        # Scripts SQL ordenados para implantação física do banco e views
│   ├── 01_criando_banco.sql
│   ├── 02_populando_banco_inserts.sql
│   ├── 03_vw_envio.sql
│   ├── 04_vw_entrega.sql
│   ├── 05_vw_itens_envio.sql
│   ├── 06_vw_faixa_peso.sql
│   ├── 07_vw_produtos.sql
│   └── 08_vw_categoria_receita.sql
├── .gitignore
├── README.md
└── requirements.txt
```

## 🚀 Como Executar o Projeto

### 1. Preparação do Ambiente Local
Clone o repositório e configure o ambiente virtual Python para instalar as dependências necessárias:

```bash
# Clonar o repositório
git clone [https://github.com/devigorll/monitoramento_logistico.git](https://github.com/devigorll/monitoramento_logistico.git)
cd monitoramento_logistico

# Criar e ativar o ambiente virtual (Windows)
python -m venv .venv
.venv\Scripts\activate

# Instalar as bibliotecas necessárias
pip install -r requirements.txt
```

### 2. Configuração do Banco de Dados (SQL Server)
1. Abra o SQL Server Management Studio (SSMS) ou sua IDE de preferência.

2. Execute o arquivo scripts/01_criando_banco.sql para estruturar as tabelas.

3. Insira as faixas de peso padrões executando o script scripts/02_populando_banco_inserts.sql.

### 3. Geração dos Dados e Engenharia
1. Execute o notebook notebooks/01_populando_faker.ipynb para alimentar o banco de dados via Python.

2. Com o banco populado, execute os scripts de 03 a 08 da pasta scripts/ para criar as views analíticas diretamente no SQL Server.

3. Explore a análise de dados contida no notebook notebooks/02_analise_exploratoria.ipynb para compreender o comportamento

## 📈 Roadmap do Projeto
[x] Modelagem do banco de dados relacional e criação das tabelas

[x] Geração de dados fictícios consistentes com Python Faker

[x] Criação de Views SQL otimizadas para consumo de BI

[x] Análise Exploratória de Dados (EDA) no Jupyter Notebook

[x] Desenvolvimento do Dashboard no Power BI

[ ] Implementação de previsões de atrasos com Machine Learning

## 👨‍💻 Autor
Igor Cruz

Focado em extrair valor de dados e transformar fluxos complexos em soluções simples e funcionais.

⭐ Se este projeto te inspirou ou ajudou de alguma forma, sinta-se à vontade para deixar uma estrela no repositório!