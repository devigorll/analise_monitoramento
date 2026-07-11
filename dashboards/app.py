import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from lifelines import KaplanMeierFitter, CoxPHFitter

# Configuradno titulo da página do streamlit
st.set_page_config(
    page_title="Dashboard Monitoramento Logístico",
    page_icon="📊",
    layout="wide"
)

# Mudando de estilo para os gráficos
sns.set_theme(style="whitegrid")

# Imprtar dados aqui 
# Gerar DF com o vw_envio
df = pd.read_csv("../data/vw_envio.csv")

# Sidebar
st.sidebar.title("Filtros Globais")
st.sidebar.markdown("Use os filtros abaixo para segmentar a visão geral:")

# Título tela inicial
st.title("📊 Monitoramento logístico: Análise de monitoramento logístico")
st.markdown("""
Este projeto foi adaptado para o streamlit visando uma interação do usuário com o projeto de análise.
""")

# Definindo abas no dashboards
tab1, tab2, tab3, tab4, tab5, tab6 = st.tabs([
    "📍 Visão Geral",
    "💰 Financeiro",
    "📊 Logística",
    "⏱️ Entregas",
    "👥 Clientes e Geografia",
    "🚚 Veículos"
])

with tab1:
    st.header("📍 Visão Geral")
    st.markdown("""
    Nesta seção, você encontrará uma visão geral do monitoramento logístico, incluindo métricas-chave e gráficos que fornecem insights sobre o desempenho das operações logísticas.
    """)
    
    col1, col2, col3 = st.columns(3)

    col1.metric("Receita total", df["valor_frete"].sum().round(2), "R$")