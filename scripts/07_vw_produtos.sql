-- VIEW PARA RETORNAR MAIS INFORMAÇÕES DO PROODUTO

CREATE OR ALTER VIEW vw_produtos AS
SELECT 
	a.id_envio,
	a.id_produto,
	a.quantidade,
	a.valor_unitario,

	b.nome,
	b.categoria

FROM itens_envio a 
INNER JOIN produtos b
ON a.id_produto = b.id_produto

SELECT * FROM vw_produtos
