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