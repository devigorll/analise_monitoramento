USE monitoramento_db

-- VIEW COM INNER JOIN PARA RETORNAR OS DADOS DO ENVIO


CREATE VIEW vw_envio AS

SELECT 
e.id_envio,
c.nome,
v.modelo,
e.data_postagem,
e.data_previsao_entrega,
e.valor_frete,
e.peso_carga

FROM 
	fato_envios e

INNER JOIN 
	clientes c ON c.id_cliente = e.id_cliente
INNER JOIN
	veiculos v ON v.id_veiculo = e.id_veiculo


SELECT * FROM vw_envio


-- VIEW COM INNER JOIN PARA RETORNAR OS DADOS DE ENTREGA E STATUS


CREATE VIEW vw_entrega AS

SELECT 
e.id_status,
e.id_envio,
c.nome_hub,
e.status,
e.ultima_atualizacao

FROM fato_status_entrega e
INNER JOIN centros_distribuicao c ON c.id_cd = e.id_cd

SELECT * FROM vw_entrega



SELECT * FROM fato_status_entrega