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