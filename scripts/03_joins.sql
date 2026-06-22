SELECT * FROM veiculos

SELECT 
e.id_envio,
c.nome,
v.modelo,
e.data_postagem,
e.data_previsao_entrega,
e.valor_frete,
e.peso_carga,
es.status

FROM 
	fato_envios e

INNER JOIN 
	clientes c ON c.id_cliente = e.id_cliente
INNER JOIN
	veiculos v ON v.id_veiculo = e.id_veiculo
INNER JOIN fato_status_entrega es ON e.id_cliente = es.id_cd





SELECT * FROM fato_status_entrega
WHERE id_envio = 5

SELECT * FROM centros_distribuicao



SELECT 
e.id_status,
e.id_envio,
c.nome_hub,
e.status,
e.ultima_atualizacao

FROM fato_status_entrega e
INNER JOIN centros_distribuicao c ON c.id_cd = e.id_cd