USE master;
GO


CREATE DATABASE monitoramento_db;
GO

USE monitoramento_db;
GO

CREATE TABLE clientes
(
    id_cliente INT IDENTITY(1,1) NOT NULL,

    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NULL,
    estado CHAR(2) NOT NULL,

    CONSTRAINT PK_Clientes
        PRIMARY KEY (id_cliente)
);
GO

CREATE TABLE veiculos
(
    id_veiculo INT IDENTITY(1,1) NOT NULL,

    modelo VARCHAR(50) NOT NULL, 

    placa CHAR(7) NOT NULL,
    capacidade_kg INT NULL,

    categoria CHAR(1) NOT NULL,

    CONSTRAINT PK_Veiculos
        PRIMARY KEY (id_veiculo),

    CONSTRAINT UQ_Veiculos_Placa
        UNIQUE (placa),

    CONSTRAINT CK_Veiculos_Capacidade
        CHECK (capacidade_kg IS NULL OR capacidade_kg > 0)
);
GO

CREATE TABLE centros_distribuicao
(
    id_cd INT IDENTITY(1,1) NOT NULL,

    nome_hub VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NULL,
    estado CHAR(2) NOT NULL,

    CONSTRAINT PK_CentrosDistribuicao
        PRIMARY KEY (id_cd)
);
GO

CREATE TABLE fato_envios
(
    id_envio INT IDENTITY(1,1) NOT NULL,

    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,

    data_postagem DATETIME NOT NULL,
    data_previsao_entrega DATETIME NOT NULL,

    valor_frete DECIMAL(10,2) NOT NULL,
    peso_carga DECIMAL(10,3) NOT NULL,

    CONSTRAINT PK_Envios
        PRIMARY KEY (id_envio),

    CONSTRAINT FK_Envios_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT FK_Envios_Veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculos(id_veiculo),

    CONSTRAINT CK_Envios_ValorFrete
        CHECK (valor_frete > 0),

    CONSTRAINT CK_Envios_PesoCarga
        CHECK (peso_carga > 0),

    CONSTRAINT CK_Envios_Datas
        CHECK (data_previsao_entrega >= data_postagem)
);
GO

CREATE TABLE fato_status_entrega
(
    id_status INT IDENTITY(1,1) NOT NULL,

    id_envio INT NOT NULL,
    id_cd INT NOT NULL,

    status VARCHAR(50) NOT NULL,
    ultima_atualizacao DATETIME NOT NULL,

    CONSTRAINT PK_StatusEntrega
        PRIMARY KEY (id_status),

    CONSTRAINT FK_Status_Envio
        FOREIGN KEY (id_envio)
        REFERENCES fato_envios(id_envio),

    CONSTRAINT FK_Status_CD
        FOREIGN KEY (id_cd)
        REFERENCES centros_distribuicao(id_cd)
);
GO

CREATE INDEX IX_Envios_Cliente
ON fato_envios(id_cliente);

CREATE INDEX IX_Envios_Veiculo
ON fato_envios(id_veiculo);

CREATE INDEX IX_Status_Envio
ON fato_status_entrega(id_envio);

CREATE INDEX IX_Status_CD
ON fato_status_entrega(id_cd);
GO

SELECT * FROM clientes;
SELECT * FROM veiculos;
SELECT * FROM centros_distribuicao;
SELECT * FROM fato_envios;
SELECT * FROM fato_status_entrega;
GO

