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
    bairro VARCHAR(80) NULL,
    cep CHAR(8) NULL,

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

CREATE TABLE faixas_peso
(
    id_faixa_peso TINYINT NOT NULL,

    descricao VARCHAR(50) NOT NULL,
    peso_min_kg DECIMAL(10,3) NULL,
    peso_max_kg DECIMAL(10,3) NULL,

    CONSTRAINT PK_FaixasPeso
        PRIMARY KEY (id_faixa_peso),

    CONSTRAINT CK_FaixasPeso_Limites
        CHECK (
            peso_min_kg IS NULL
            OR peso_max_kg IS NULL
            OR peso_max_kg >= peso_min_kg
        )
);
GO

CREATE TABLE produtos
(
    id_produto INT IDENTITY(1,1) NOT NULL,

    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    id_faixa_peso TINYINT NOT NULL,

    CONSTRAINT PK_Produtos
        PRIMARY KEY (id_produto),

    CONSTRAINT FK_Produtos_FaixaPeso
        FOREIGN KEY (id_faixa_peso)
        REFERENCES faixas_peso(id_faixa_peso)
);
GO

CREATE TABLE status_entrega
(
    id_status_entrega TINYINT NOT NULL,

    descricao VARCHAR(50) NOT NULL,

    CONSTRAINT PK_StatusEntrega_Dominio
        PRIMARY KEY (id_status_entrega),

    CONSTRAINT UQ_StatusEntrega_Descricao
        UNIQUE (descricao)
);
GO

CREATE TABLE fato_envios
(
    id_envio INT IDENTITY(1,1) NOT NULL,

    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_cd_origem INT NULL,
    id_cd_destino INT NULL,

    data_postagem DATETIME NOT NULL,
    data_previsao_entrega DATETIME NOT NULL,
    data_entrega_real DATETIME NULL,

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

    CONSTRAINT FK_Envios_CDOrigem
        FOREIGN KEY (id_cd_origem)
        REFERENCES centros_distribuicao(id_cd),

    CONSTRAINT FK_Envios_CDDestino
        FOREIGN KEY (id_cd_destino)
        REFERENCES centros_distribuicao(id_cd),

    CONSTRAINT CK_Envios_ValorFrete
        CHECK (valor_frete > 0),

    CONSTRAINT CK_Envios_PesoCarga
        CHECK (peso_carga > 0),

    CONSTRAINT CK_Envios_Datas
        CHECK (data_previsao_entrega >= data_postagem),

    CONSTRAINT CK_Envios_DataEntregaReal
        CHECK (data_entrega_real IS NULL OR data_entrega_real >= data_postagem)
);
GO

CREATE TABLE itens_envio
(
    id_item_envio INT IDENTITY(1,1) NOT NULL,

    id_envio INT NOT NULL,
    id_produto INT NOT NULL,

    quantidade INT NOT NULL,
    peso_unitario DECIMAL(10,3) NULL,
    valor_unitario DECIMAL(10,2) NULL,

    CONSTRAINT PK_ItensEnvio
        PRIMARY KEY (id_item_envio),

    CONSTRAINT FK_ItensEnvio_Envio
        FOREIGN KEY (id_envio)
        REFERENCES fato_envios(id_envio),

    CONSTRAINT FK_ItensEnvio_Produto
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto),

    CONSTRAINT CK_ItensEnvio_Quantidade
        CHECK (quantidade > 0),

    CONSTRAINT CK_ItensEnvio_PesoUnitario
        CHECK (peso_unitario IS NULL OR peso_unitario > 0),

    CONSTRAINT CK_ItensEnvio_ValorUnitario
        CHECK (valor_unitario IS NULL OR valor_unitario >= 0)
);
GO

CREATE TABLE fato_status_entrega
(
    id_status INT IDENTITY(1,1) NOT NULL,

    id_envio INT NOT NULL,
    id_cd INT NOT NULL,
    id_status_entrega TINYINT NOT NULL,

    ultima_atualizacao DATETIME NOT NULL,

    CONSTRAINT PK_StatusEntrega
        PRIMARY KEY (id_status),

    CONSTRAINT FK_Status_Envio
        FOREIGN KEY (id_envio)
        REFERENCES fato_envios(id_envio),

    CONSTRAINT FK_Status_CD
        FOREIGN KEY (id_cd)
        REFERENCES centros_distribuicao(id_cd),

    CONSTRAINT FK_Status_StatusEntrega
        FOREIGN KEY (id_status_entrega)
        REFERENCES status_entrega(id_status_entrega)
);
GO

INSERT INTO faixas_peso
(
    id_faixa_peso,
    descricao,
    peso_min_kg,
    peso_max_kg
)
VALUES
(1, 'Leve', 0.001, 5.000),
(2, 'Medio', 5.001, 30)