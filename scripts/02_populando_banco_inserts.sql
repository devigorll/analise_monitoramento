-- ESTE ARQUIVO NÃO SERÁ UTILIZADO POIS UTILIZEI O FAKER, IREI REMOVER DO PROJETO

-- INSERT CLIENTES

INSERT INTO clientes (nome, cidade, estado)
VALUES
('Mercado Silva', 'São Paulo', 'SP'),
('Loja Oliveira', 'Campinas', 'SP'),
('Comercial Santos', 'Santos', 'SP'),
('Distribuidora Costa', 'Rio de Janeiro', 'RJ'),
('Atacado Ferreira', 'Niterói', 'RJ'),
('Magazine Souza', 'Belo Horizonte', 'MG'),
('Comercial Lima', 'Uberlândia', 'MG'),
('Mercado Rocha', 'Curitiba', 'PR'),
('Loja Martins', 'Londrina', 'PR'),
('Distribuidora Alves', 'Porto Alegre', 'RS'),
('Comercial Gomes', 'Caxias do Sul', 'RS'),
('Atacado Pereira', 'Florianópolis', 'SC'),
('Mercado Barbosa', 'Joinville', 'SC'),
('Loja Rodrigues', 'Salvador', 'BA'),
('Distribuidora Ribeiro', 'Feira de Santana', 'BA'),
('Comercial Almeida', 'Recife', 'PE'),
('Mercado Cardoso', 'Fortaleza', 'CE'),
('Atacado Teixeira', 'Manaus', 'AM'),
('Loja Carvalho', 'Belém', 'PA'),
('Distribuidora Araujo', 'Brasília', 'DF');

SELECT * FROM clientes

-- INSERTS VEICULOS

INSERT INTO veiculos (placa, capacidade_kg)
VALUES
('BRA1A23', 500),
('BRA2B34', 800),
('BRA3C45', 1000),
('BRA4D56', 1500),
('BRA5E67', 2000),
('BRA6F78', 2500),
('BRA7G89', 3000),
('BRA8H90', 3500),
('BRA9J12', 5000),
('BRA0K34', 8000);

-- INSERT CENTROS DE DISTRIBUIÇÃO

INSERT INTO centros_distribuicao
(nome_hub, cidade, estado)
VALUES
('CD São Paulo', 'São Paulo', 'SP'),
('CD Campinas', 'Campinas', 'SP'),
('CD Rio de Janeiro', 'Rio de Janeiro', 'RJ'),
('CD Belo Horizonte', 'Belo Horizonte', 'MG'),
('CD Curitiba', 'Curitiba', 'PR'),
('CD Porto Alegre', 'Porto Alegre', 'RS'),
('CD Salvador', 'Salvador', 'BA'),
('CD Recife', 'Recife', 'PE'),
('CD Fortaleza', 'Fortaleza', 'CE'),
('CD Brasília', 'Brasília', 'DF');

-- INSERT ENVIOS

INSERT INTO fato_envios
(
    id_cliente,
    id_veiculo,
    data_postagem,
    data_previsao_entrega,
    valor_frete,
    peso_carga
)
VALUES

(3,7,'20260510 08:32:00','20260515 00:00:00',89.90,120.500),

(15,2,'20260510 14:17:00','20260513 00:00:00',45.50,38.250),

(7,9,'20260511 09:05:00','20260518 00:00:00',310.75,1870.000),

(1,4,'20260511 16:42:00','20260514 00:00:00',78.30,210.400),

(18,10,'20260512 07:18:00','20260520 00:00:00',540.00,4250.000),

(6,1,'20260512 11:55:00','20260516 00:00:00',39.90,22.300),

(11,8,'20260513 15:20:00','20260519 00:00:00',285.60,1325.000),

(3,3,'20260513 17:08:00','20260515 00:00:00',59.90,95.500),

(20,5,'20260514 08:40:00','20260521 00:00:00',190.25,830.700),

(9,7,'20260514 13:22:00','20260517 00:00:00',72.40,150.000);

-- INSERT STATUS ENTREGA

INSERT INTO fato_status_entrega
(
    id_envio,
    id_cd,
    status,
    ultima_atualizacao
)
VALUES

-- ENVIO 4
(4,1,'Postado','20260510 08:32:00'),
(4,1,'Recebido no CD','20260510 12:15:00'),
(4,1,'Em transferência','20260511 05:20:00'),
(4,5,'Chegada ao CD destino','20260512 14:50:00'),
(4,5,'Saiu para entrega','20260513 08:12:00'),
(4,5,'Entregue','20260513 15:47:00'),

-- ENVIO 5
(5,1,'Postado','20260510 14:17:00'),
(5,1,'Recebido no CD','20260510 18:30:00'),
(5,3,'Em trânsito','20260511 07:45:00'),
(5,3,'Saiu para entrega','20260512 08:10:00'),
(5,3,'Entregue','20260512 13:55:00'),

-- ENVIO 6
(6,4,'Postado','20260511 09:05:00'),
(6,4,'Recebido no CD','20260511 13:40:00'),
(6,4,'Em transferência','20260512 06:30:00'),
(6,5,'Chegada ao CD destino','20260513 17:20:00'),
(6,5,'Saiu para entrega','20260514 09:10:00'),
(6,5,'Entregue','20260514 16:25:00'),

-- ENVIO 7
(7,3,'Postado','20260511 16:42:00'),
(7,3,'Recebido no CD','20260511 19:00:00'),
(7,3,'Ocorrência operacional','20260512 10:25:00'),
(7,3,'Em trânsito','20260513 07:15:00'),
(7,3,'Saiu para entrega','20260514 08:05:00'),
(7,3,'Entregue','20260514 17:30:00'),

-- ENVIO 8
(8,6,'Postado','20260512 07:18:00'),
(8,6,'Recebido no CD','20260512 11:10:00'),
(8,6,'Em transferência','20260513 05:45:00'),
(8,7,'Chegada ao CD destino','20260515 14:00:00'),
(8,7,'Saiu para entrega','20260516 08:20:00'),
(8,7,'Entregue','20260516 18:15:00'),

-- ENVIO 9
(9,2,'Postado','20260512 11:55:00'),
(9,2,'Recebido no CD','20260512 15:05:00'),
(9,2,'Em trânsito','20260513 08:00:00'),
(9,2,'Entregue','20260514 14:10:00'),

-- ENVIO 10
(10,8,'Postado','20260513 15:20:00'),
(10,8,'Recebido no CD','20260513 19:45:00'),
(10,8,'Aguardando transferência','20260514 09:30:00'),
(10,8,'Em trânsito','20260515 06:10:00'),
(10,9,'Chegada ao CD destino','20260516 13:40:00'),

-- ENVIO 11
(11,1,'Postado','20260513 17:08:00'),
(11,1,'Recebido no CD','20260513 20:00:00'),
(11,1,'Em trânsito','20260514 07:00:00'),
(11,1,'Saiu para entrega','20260515 08:15:00'),
(11,1,'Entregue','20260515 12:30:00'),

-- ENVIO 12
(12,10,'Postado','20260514 08:40:00'),
(12,10,'Recebido no CD','20260514 11:30:00'),
(12,10,'Ocorrência operacional','20260515 16:20:00'),
(12,10,'Atrasado','20260516 09:45:00'),

-- ENVIO 13
(13,2,'Postado','20260514 13:22:00'),
(13,2,'Recebido no CD','20260514 17:10:00'),
(13,2,'Em trânsito','20260515 07:30:00'),
(13,2,'Saiu para entrega','20260516 08:00:00'),
(13,2,'Entregue','20260516 15:40:00');