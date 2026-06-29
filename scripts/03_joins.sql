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


-- VIEW PARA RETORNAR OS DADOS DE ENTREGA E STATUS

CREATE VIEW vw_entrega AS
SELECT 
    fse.id_status,
    fse.id_envio,

    cd.id_cd,
    cd.nome_hub,
    cd.cidade,
    cd.estado,

    se.id_status_entrega,
    se.descricao AS status_entrega,

    fse.ultima_atualizacao

FROM fato_status_entrega fse
INNER JOIN centros_distribuicao cd
    ON cd.id_cd = fse.id_cd
INNER JOIN status_entrega se
    ON se.id_status_entrega = fse.id_status_entrega;

SELECT * FROM vw_entrega;

-- VIEW PARA RETORNAR OS PRODUTOS DE CADA ENVIO

CREATE VIEW vw_itens_envio AS
SELECT
    ie.id_item_envio,
    ie.id_envio,

    p.id_produto,
    p.nome AS produto,
    p.categoria AS categoria_produto,

    fp.id_faixa_peso,
    fp.descricao AS faixa_peso,

    ie.quantidade,
    ie.peso_unitario,
    ie.valor_unitario,

    (ie.quantidade * ISNULL(ie.peso_unitario, 0)) AS peso_total_item,
    (ie.quantidade * ISNULL(ie.valor_unitario, 0)) AS valor_total_item

FROM itens_envio ie
INNER JOIN produtos p
    ON p.id_produto = ie.id_produto
INNER JOIN faixas_peso fp
    ON fp.id_faixa_peso = p.id_faixa_peso;
