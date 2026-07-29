-- VIEW PARA RETORNAR A FAIXA DE PESO DE CADA ENVIO

CREATE VIEW vw_faixa_peso AS
SELECT
    e.id_envio,
    e.valor_frete,
    fp.descricao AS faixa_peso,
    e.peso_carga

FROM fato_envios e
INNER JOIN faixas_peso fp
    ON (
        (fp.peso_min_kg IS NULL OR e.peso_carga >= fp.peso_min_kg)
        AND
        (fp.peso_max_kg IS NULL OR e.peso_carga <= fp.peso_max_kg)
    );
