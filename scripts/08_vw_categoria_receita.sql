-- VIEW PARA CRIAR GRÁFICO CATEGORIA X RECEITA

CREATE OR ALTER VIEW vw_categoria_receita AS
SELECT 
    fp.id_faixa_peso,
    fe.peso_carga AS peso,
    fp.descricao,
    fe.valor_frete
FROM fato_envios AS fe
INNER JOIN faixas_peso AS fp 
    ON fe.peso_carga >= COALESCE(fp.peso_min_kg, 0)
    AND fe.peso_carga <= COALESCE(fp.peso_max_kg, 999999.999);