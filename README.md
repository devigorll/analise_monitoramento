# 🚚 Sistema de Monitoramento Logístico: Rastreamento de Entregas e Inteligência Operacional

![Status do Projeto](https://img.shields.io/badge/Status-Em%20Desenvolvimento-orange)
![Linguagem](https://img.shields.io/badge/Language-Python-blue)
![Banco de Dados](https://img.shields.io/badge/Database-SQL%20Server-red)
![Área](https://img.shields.io/badge/Area-Logística-green)

Este projeto simula uma operação logística completa, permitindo o monitoramento de entregas, rastreamento de encomendas e análise de desempenho operacional através de técnicas de Engenharia de Dados, Banco de Dados, Business Intelligence e Análise de Dados.

A solução foi desenvolvida para representar cenários reais enfrentados por transportadoras, operadores logísticos e empresas de comércio eletrônico, possibilitando a geração de indicadores estratégicos para apoio à tomada de decisão.

---

# 📌 Índice

* [Contexto do Negócio](#-contexto-do-negócio)
* [Objetivos do Projeto](#-objetivos-do-projeto)
* [Funcionalidades e Etapas Tecnológicas](#-funcionalidades-e-etapas-tecnológicas)
* [Tecnologias Utilizadas](#-tecnologias-utilizadas)
* [Estrutura do Banco de Dados](#-estrutura-do-banco-de-dados)
* [Estrutura do Repositório](#-estrutura-do-repositório)
* [Como Executar o Projeto](#-como-executar-o-projeto)
* [Roadmap](#-roadmap)
* [Autor](#-autor)

---

# 💼 Contexto do Negócio

Empresas de logística precisam monitorar diariamente milhares de entregas, veículos, centros de distribuição e movimentações operacionais.

Sem mecanismos adequados de monitoramento, problemas como atrasos, baixa utilização da frota, aumento dos custos operacionais e gargalos logísticos podem impactar diretamente a qualidade do serviço prestado.

Este projeto foi desenvolvido para transformar dados operacionais em informações estratégicas, permitindo responder perguntas importantes como:

* Qual o volume total de entregas realizadas?
* Quais centros de distribuição processam mais cargas?
* Qual o tempo médio de entrega?
* Quais clientes geram maior receita?
* Onde estão os principais gargalos da operação?
* Quais rotas apresentam maior incidência de atrasos?

---

# 🎯 Objetivos do Projeto

O projeto busca simular uma operação logística real, permitindo:

* Monitorar envios e rastreamentos.
* Acompanhar movimentações em centros de distribuição.
* Avaliar o desempenho operacional da frota.
* Analisar receitas provenientes dos fretes.
* Identificar gargalos e oportunidades de melhoria.
* Construir dashboards e indicadores gerenciais.
* Aplicar conceitos de Engenharia de Dados e Business Intelligence.

---

# ⚙️ Funcionalidades e Etapas Tecnológicas

O desenvolvimento do projeto foi dividido em etapas práticas e progressivas.

## ✅ 01. Modelagem e Estruturação do Banco de Dados

* Definição das entidades do sistema.
* Construção do DER.
* Definição de chaves primárias e estrangeiras.
* Implementação física no SQL Server.
* Validação dos relacionamentos.

---

## ✅ 02. Geração e Alimentação dos Dados

* Utilização da biblioteca Faker.
* Geração de clientes fictícios.
* Geração de veículos e placas.
* Criação de centros de distribuição.
* Simulação de milhares de envios.
* Simulação de eventos de rastreamento.

---

## 🔄 03. Engenharia e Preparação dos Dados

* Conexão Python ↔ SQL Server.
* Extração dos dados.
* Tratamento de inconsistências.
* Criação de variáveis derivadas.
* Cálculo de prazos e atrasos.

---

## 🔄 04. Análise Exploratória de Dados (EDA)

* Volume total de envios.
* Distribuição dos pesos transportados.
* Distribuição dos valores de frete.
* Evolução temporal das entregas.
* Frequência dos status logísticos.
* Distribuição geográfica dos clientes.

---

## 🔄 05. Construção dos KPIs

### Indicadores Operacionais

* Total de envios.
* Total de entregas concluídas.
* Taxa de conclusão.

### Indicadores de Prazo

* Tempo médio de entrega.
* Percentual de atrasos.
* Entregas dentro do prazo.

### Indicadores Financeiros

* Receita total.
* Receita por cliente.
* Receita por estado.

### Indicadores de Transporte

* Peso total transportado.
* Utilização da frota.
* Volume por tipo de veículo.

---

## 🔄 06. Diagnóstico e Insights Estratégicos

* Identificação de gargalos.
* Centros mais congestionados.
* Veículos mais eficientes.
* Regiões mais lucrativas.
* Rotas com maior incidência de atrasos.

---

## 🔄 07. Desenvolvimento do Dashboard

* Visão Executiva.
* Visão Operacional.
* Visão Financeira.
* Visão Geográfica.
* Storytelling dos indicadores.

---

# 🛠️ Tecnologias Utilizadas

## Banco de Dados

* SQL Server

## Linguagem

* Python 3.10+

## Bibliotecas

* Pandas
* NumPy
* Faker
* Matplotlib
* Seaborn
* PyODBC

## Ferramentas

* SQL Server Management Studio (SSMS)
* Visual Studio Code
* Jupyter Notebook
* Git e GitHub
* Power BI (planejado)

---

# 🗄️ Estrutura do Banco de Dados

A modelagem foi construída utilizando conceitos de banco de dados relacional e modelagem dimensional.

## Tabelas de Dimensão

### Clientes

Armazena informações cadastrais dos clientes:

* Nome
* Cidade
* Estado

### Veículos

Armazena informações da frota:

* Modelo
* Placa
* Capacidade de carga

### Centros de Distribuição

Representa os hubs logísticos:

* Nome do centro
* Cidade
* Estado

---

## Tabelas Fato

### Fato Envios

Registra:

* Cliente responsável
* Veículo utilizado
* Peso da carga
* Valor do frete
* Data de postagem
* Data prevista de entrega

### Fato Status Entrega

Registra:

* Histórico de rastreamento
* Status da encomenda
* Centro de distribuição
* Data e hora da movimentação

---

## Relacionamentos

```text
CLIENTES
    │
    └──< ENVIOS >── VEICULOS
             │
             │
             └──< STATUS_ENTREGA >── CENTROS_DISTRIBUICAO
```

---

# 📁 Estrutura do Repositório

```text
MONITORAMENTO_LOGISTICO/
│
├── app/
│   └── app.py
│
├── data/
│
├── documentos/
│
├── notebooks/
│   └── 01_populando_faker.ipynb
│
├── scripts/
│   ├── 01_criando_banco.sql
│   └── 02_populando_banco_inserts.sql
│
├── .venv/
│
├── .gitignore
│
├── README.md
│
└── requirements.txt
```

---

# 🚀 Como Executar o Projeto

## 1. Clonar o Repositório

```bash
git clone https://github.com/devigorll/monitoramento_logistico.git
```

## 2. Acessar a Pasta

```bash
cd monitoramento_logistico
```

## 3. Criar Ambiente Virtual

```bash
python -m venv .venv
```

## 4. Ativar Ambiente

### Windows

```bash
.venv\Scripts\activate
```

### Linux / Mac

```bash
source .venv/bin/activate
```

## 5. Instalar Dependências

```bash
pip install -r requirements.txt
```

## 6. Criar Banco de Dados

Execute:

```sql
scripts/01_criando_banco.sql
```

## 7. Popular Banco

Execute:

```sql
scripts/02_populando_banco_inserts.sql
```

## 8. Executar Notebook

```bash
notebooks/01_populando_faker.ipynb
```

---

# 📈 Roadmap

* [x] Modelagem do banco de dados
* [x] Criação das tabelas
* [x] Geração de dados fictícios
* [x] População inicial do banco
* [ ] Engenharia de dados
* [ ] Análise exploratória (EDA)
* [ ] Construção dos KPIs
* [ ] Dashboard Power BI
* [ ] Storytelling Executivo
* [ ] Publicação do projeto

---

# 👨‍💻 Autor

**Igor Cruz**

Projeto desenvolvido para aprimorar conhecimentos em:

* SQL Server
* Engenharia de Dados
* Data Analytics
* Business Intelligence
* Modelagem de Dados
* Desenvolvimento de Portfólio

---

⭐ Caso tenha gostado do projeto, considere deixar uma estrela no repositório.
