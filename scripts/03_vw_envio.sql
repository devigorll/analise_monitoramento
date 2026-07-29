use monitoramento_db

-- VIEW PARA RETORNAR OS DADOS GERAIS DO ENVIO

CREATE OR ALTER VIEW vw_envio AS
SELECT 
    e.id_envio,

    c.id_cliente,
    c.nome AS cliente,
    c.cidade AS cidade_cliente,
    c.estado AS estado_cliente,

    v.id_veiculo,
    v.modelo AS veiculo,
    v.placa,
    v.categoria AS categoria_veiculo,

    cd_origem.nome_hub AS cd_origem,
    cd_origem.cidade AS cidade_origem,
    cd_origem.estado AS estado_origem,

    cd_destino.nome_hub AS cd_destino,
    cd_destino.cidade AS cidade_destino,
    cd_destino.estado AS estado_destino,

    e.data_postagem,
    e.data_previsao_entrega,
    e.data_entrega_real,

    e.valor_frete,
    e.peso_carga

FROM fato_envios e
INNER JOIN clientes c
    ON c.id_cliente = e.id_cliente
INNER JOIN veiculos v
    ON v.id_veiculo = e.id_veiculo
LEFT JOIN centros_distribuicao cd_origem
    ON cd_origem.id_cd = e.id_cd_origem
LEFT JOIN centros_distribuicao cd_destino
    ON cd_destino.id_cd = e.id_cd_destino;







