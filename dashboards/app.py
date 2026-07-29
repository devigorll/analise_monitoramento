import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path

# Configurando título e layout da página do Streamlit
st.set_page_config(
    page_title="Dashboard Monitoramento Logístico",
    page_icon="📊",
    layout="wide"
)

# Estilo para os gráficos
sns.set_theme(style="whitegrid")

# Função auxiliar de formatação de moeda em BRL
def moeda_br(valor):
    return f"R$ {valor:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")

# Importação de dados segura
BASE_DIR = Path(__file__).resolve().parent
arquivo = BASE_DIR.parent / "data" / "vw_envio.csv"

# Fallback para leitura local caso esteja na mesma pasta
if not arquivo.exists():
    arquivo = BASE_DIR / "vw_envio.csv"

@st.cache_data
def carregar_dados(caminho):
    df = pd.read_csv(caminho)
    # Conversão de datas
    df["data_postagem"] = pd.to_datetime(df["data_postagem"])
    df["data_previsao_entrega"] = pd.to_datetime(df["data_previsao_entrega"])
    df["data_entrega_real"] = pd.to_datetime(df["data_entrega_real"])
    
    # Colunas calculadas de logística e prazos
    df["status_entrega"] = np.where(df["data_entrega_real"].notnull(), "Entregue", "Em Trânsito")
    
    # Dias calculados
    df["dias_previstos"] = (df["data_previsao_entrega"] - df["data_postagem"]).dt.days
    df["dias_reais"] = (df["data_entrega_real"] - df["data_postagem"]).dt.days
    
    # Status de pontualidade para os entregues
    df["status_prazo"] = "Em Trânsito"
    mask_entregue = df["data_entrega_real"].notnull()
    df.loc[mask_entregue & (df["data_entrega_real"] <= df["data_previsao_entrega"]), "status_prazo"] = "No Prazo"
    df.loc[mask_entregue & (df["data_entrega_real"] > df["data_previsao_entrega"]), "status_prazo"] = "Atrasado"
    
    # Mês do envio
    df["mes_postagem"] = df["data_postagem"].dt.to_period("M").astype(str)
    
    return df

try:
    df_raw = carregar_dados(arquivo)
except Exception as e:
    st.error(f"Erro ao carregar o arquivo de dados: {e}")
    st.stop()


# SIDEBAR - FILTROS GLOBAIS

st.sidebar.title("📌 Filtros Globais")
st.sidebar.markdown("Use os filtros abaixo para segmentar as análises:")

# Filtro de Data
min_data = df_raw["data_postagem"].min().date()
max_data = df_raw["data_postagem"].max().date()

intervalo_data = st.sidebar.date_input(
    "Período de Postagem",
    value=(min_data, max_data),
    min_value=min_data,
    max_value=max_data
)

# Filtro de Estados
estados_origem = ["Todos"] + sorted(df_raw["estado_origem"].unique().tolist())
estado_orig_sel = st.sidebar.selectbox("Estado de Origem", estados_origem)

estados_destino = ["Todos"] + sorted(df_raw["estado_destino"].unique().tolist())
estado_dest_sel = st.sidebar.selectbox("Estado de Destino", estados_destino)

# Filtro de Categoria de Veículo
categorias = ["Todas"] + sorted(df_raw["categoria_veiculo"].unique().tolist())
categoria_sel = st.sidebar.selectbox("Categoria do Veículo", categorias)

# Aplicando Filtros ao DataFrame
df = df_raw.copy()

if len(intervalo_data) == 2:
    data_inicio, data_fim = intervalo_data
    df = df[(df["data_postagem"].dt.date >= data_inicio) & (df["data_postagem"].dt.date <= data_fim)]

if estado_orig_sel != "Todos":
    df = df[df["estado_origem"] == estado_orig_sel]

if estado_dest_sel != "Todos":
    df = df[df["estado_destino"] == estado_dest_sel]

if categoria_sel != "Todas":
    df = df[df["categoria_veiculo"] == categoria_sel]


# CABEÇALHO

st.title("📊 Monitoramento Logístico: Análise Operacional e Financeira")
st.markdown("Visão integrada de indicadores de frete, performance de entregas, clientes e frota de veículos.")

# Definindo abas do dashboard
tab1, tab2, tab3, tab4, tab5, tab6 = st.tabs([
    "📍 Visão Geral",
    "💰 Financeiro",
    "📊 Logística",
    "⏱️ Entregas",
    "👥 Clientes e Geografia",
    "🚚 Veículos"
])


# TAB 1: VISÃO GERAL

with tab1:
    st.header("📍 Visão Geral das Operações")
    st.markdown("Métricas fundamentais e resumo geral do volume de fretes.")

    col1, col2, col3, col4 = st.columns(4)

    total_receita = df["valor_frete"].sum()
    total_envios = len(df)
    total_peso = df["peso_carga"].sum()
    taxa_entregues = (df["status_entrega"] == "Entregue").mean() * 100 if total_envios > 0 else 0

    col1.metric("Receita Total", moeda_br(total_receita))
    col2.metric("Total de Envios", f"{total_envios:,}".replace(",", "."))
    col3.metric("Peso Carga Total", f"{total_peso:,.1f} kg".replace(",", "X").replace(".", ",").replace("X", "."))
    col4.metric("Taxa de Entregas Concluídas", f"{taxa_entregues:.1f}%")

    st.markdown("---")
    
    col_g1, col_g2 = st.columns(2)

    with col_g1:
        st.subheader("Evolução Mensal de Envios")
        df_mes = df.groupby("mes_postagem")["id_envio"].count().reset_index()
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.lineplot(data=df_mes, x="mes_postagem", y="id_envio", marker="o", ax=ax, color="#1f77b4")
        plt.xticks(rotation=45)
        ax.set_xlabel("Mês")
        ax.set_ylabel("Quantidade de Envios")
        st.pyplot(fig)

    with col_g2:
        st.subheader("Status das Cargas")
        df_status = df["status_prazo"].value_counts().reset_index()
        df_status.columns = ["Status", "Quantidade"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_status, x="Status", y="Quantidade", palette="Set2", ax=ax)
        ax.set_xlabel("")
        ax.set_ylabel("Quantidade")
        st.pyplot(fig)


# TAB 2: FINANCEIRO

with tab2:
    st.header("💰 Análise Financeira")
    st.markdown("Acompanhamento do faturamento com fretes, ticket médio e distribuição por rotas.")

    col1, col2, col3 = st.columns(3)
    
    ticket_medio = df["valor_frete"].mean() if len(df) > 0 else 0
    maior_frete = df["valor_frete"].max() if len(df) > 0 else 0
    menor_frete = df["valor_frete"].min() if len(df) > 0 else 0

    col1.metric("Ticket Médio do Frete", moeda_br(ticket_medio))
    col2.metric("Maior Frete Registrado", moeda_br(maior_frete))
    col3.metric("Menor Frete Registrado", moeda_br(menor_frete))

    st.markdown("---")

    col_f1, col_f2 = st.columns(2)

    with col_f1:
        st.subheader("Top 10 Centros de Origem por Receita")
        df_cd_rec = df.groupby("cd_origem")["valor_frete"].sum().reset_index().sort_values(by="valor_frete", ascending=False).head(10)
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_cd_rec, y="cd_origem", x="valor_frete", palette="Blues_r", ax=ax)
        ax.set_xlabel("Receita Total (R$)")
        ax.set_ylabel("Centro de Distribuição")
        st.pyplot(fig)

    with col_f2:
        st.subheader("Relação entre Peso da Carga e Valor do Frete")
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.scatterplot(data=df, x="peso_carga", y="valor_frete", alpha=0.6, color="#2ca02c", ax=ax)
        ax.set_xlabel("Peso da Carga (kg)")
        ax.set_ylabel("Valor do Frete (R$)")
        st.pyplot(fig)


# TAB 3: LOGÍSTICA

with tab3:
    st.header("📊 Desempenho Logístico e Operacional")
    st.markdown("Fluxo de movimentação de cargas entre origens e destinos.")

    col_l1, col_l2 = st.columns(2)

    with col_l1:
        st.subheader("Top Estados de Origem por Volume de Cargas")
        df_orig = df["estado_origem"].value_counts().reset_index().head(10)
        df_orig.columns = ["Estado", "Envios"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_orig, x="Estado", y="Envios", palette="viridis", ax=ax)
        ax.set_ylabel("Quantidade de Envios")
        st.pyplot(fig)

    with col_l2:
        st.subheader("Top Estados de Destino por Volume de Cargas")
        df_dest = df["estado_destino"].value_counts().reset_index().head(10)
        df_dest.columns = ["Estado", "Envios"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_dest, x="Estado", y="Envios", palette="magma", ax=ax)
        ax.set_ylabel("Quantidade de Envios")
        st.pyplot(fig)


# TAB 4: ENTREGAS

with tab4:
    st.header("⏱️ Análise de Prazos e Entregas")
    st.markdown("Indicadores de cumprimento dos prazos estipulados e SLA.")

    df_entregues = df[df["status_entrega"] == "Entregue"]

    col1, col2, col3 = st.columns(3)

    tot_entregues = len(df_entregues)
    tot_no_prazo = (df_entregues["status_prazo"] == "No Prazo").sum()
    pct_pontualidade = (tot_no_prazo / tot_entregues * 100) if tot_entregues > 0 else 0
    tempo_medio_real = df_entregues["dias_reais"].mean() if tot_entregues > 0 else 0

    col1.metric("Total Entregue", f"{tot_entregues}")
    col2.metric("Índice de Pontualidade (SLA)", f"{pct_pontualidade:.1f}%")
    col3.metric("Tempo Médio Real de Transporte", f"{tempo_medio_real:.1f} dias")

    st.markdown("---")

    col_e1, col_e2 = st.columns(2)

    with col_e1:
        st.subheader("Distribuição do Tempo de Entrega (Dias Reais)")
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.histplot(df_entregues["dias_reais"], bins=15, kde=True, color="#ff7f0e", ax=ax)
        ax.set_xlabel("Dias Decorridos até a Entrega")
        ax.set_ylabel("Frequência de Envios")
        st.pyplot(fig)

    with col_e2:
        st.subheader("Comparativo: Dias Previstos vs. Dias Reais")
        df_comp = df_entregues[["dias_previstos", "dias_reais"]].mean().reset_index()
        df_comp.columns = ["Tipo", "Média de Dias"]
        df_comp["Tipo"] = df_comp["Tipo"].map({"dias_previstos": "Previsto", "dias_reais": "Real"})
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_comp, x="Tipo", y="Média de Dias", palette="Oranges", ax=ax)
        st.pyplot(fig)


# TAB 5: CLIENTES E GEOGRAFIA

with tab5:
    st.header("👥 Clientes e Análise Geográfica")
    st.markdown("Análise da carteira de clientes ativas e distribuição espacial dos pedidos.")

    col_c1, col_c2 = st.columns(2)

    with col_c1:
        st.subheader("Top 10 Clientes por Faturamento em Fretes")
        df_cli_rec = df.groupby("cliente")["valor_frete"].sum().reset_index().sort_values(by="valor_frete", ascending=False).head(10)
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_cli_rec, y="cliente", x="valor_frete", palette="Purples_r", ax=ax)
        ax.set_xlabel("Faturamento Total em Fretes (R$)")
        ax.set_ylabel("Cliente")
        st.pyplot(fig)

    with col_c2:
        st.subheader("Top 10 Cidades de Destino dos Clientes")
        df_cid = df["cidade_cliente"].value_counts().reset_index().head(10)
        df_cid.columns = ["Cidade", "Envios"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_cid, y="Cidade", x="Envios", palette="Greens_r", ax=ax)
        ax.set_xlabel("Quantidade de Pedidos")
        st.pyplot(fig)


# TAB 6: VEÍCULOS

with tab6:
    st.header("🚚 Frota e Veículos")
    st.markdown("Utilização dos veículos e categorias de suporte às entregas.")

    col_v1, col_v2 = st.columns(2)

    with col_v1:
        st.subheader("Uso dos Veículos por Categoria")
        df_cat = df["categoria_veiculo"].value_counts().reset_index()
        df_cat.columns = ["Categoria", "Total de Envios"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_cat, x="Categoria", y="Total de Envios", palette="coolwarm", ax=ax)
        ax.set_xlabel("Categoria do Veículo")
        ax.set_ylabel("Total de Viagens/Envios")
        st.pyplot(fig)

    with col_v2:
        st.subheader("Top 10 Modelos de Veículos Mais Utilizados")
        df_veic = df["veiculo"].value_counts().reset_index().head(10)
        df_veic.columns = ["Modelo", "Quantidade"]
        fig, ax = plt.subplots(figsize=(8, 4))
        sns.barplot(data=df_veic, y="Modelo", x="Quantidade", palette="YlGnBu_r", ax=ax)
        ax.set_xlabel("Quantidade de Transportes")
        ax.set_ylabel("Modelo de Veículo")
        st.pyplot(fig)