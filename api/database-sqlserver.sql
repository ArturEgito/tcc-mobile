-- Banco de dados FinnTech para SQL Server
CREATE DATABASE finntech;
GO

USE;
GO

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    telefone NVARCHAR(20),
    senha NVARCHAR(255) NOT NULL,
    avatar_index INT DEFAULT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE()
);
GO

-- Tabela de produtos
CREATE TABLE produtos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255) NOT NULL,
    descricao NTEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria NVARCHAR(100) NOT NULL,
    imagem_url NVARCHAR(500),
    ativo BIT DEFAULT 1,
    created_at DATETIME2 DEFAULT GETDATE()
);
GO

-- Tabela de pedidos
CREATE TABLE pedidos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT,
    produto_id INT,
    quantidade INT DEFAULT 1,
    preco_total DECIMAL(10,2) NOT NULL,
    forma_pagamento NVARCHAR(20) CHECK (forma_pagamento IN ('dinheiro', 'credito', 'debito', 'pix')) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('pendente', 'pago', 'cancelado')) DEFAULT 'pendente',
    numero_atendimento NVARCHAR(10),
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
GO

-- Inserir produtos iniciais
INSERT INTO produtos (nome, descricao, preco, categoria, imagem_url) VALUES
('Margherita', 'Uma pizza clássica com molho de tomate, queijo mussarela e manjericão fresco.', 25.00, 'Salgadinhos', 'https://i.imgur.com/0umadnY.jpg'),
('Pepperoni', 'Deliciosa pizza com molho de tomate, queijo mussarela e fatias de pepperoni crocante.', 30.00, 'Salgadinhos', 'https://i.imgur.com/7D6bA2R.jpg'),
('Sorvete de Chocolate', 'Sorvete cremoso de chocolate com pedaços de chocolate.', 20.00, 'Sorvetes', 'https://i.imgur.com/o8cd4Gg.jpg'),
('Suco de Laranja', 'Refresco natural de laranja, fresco e saboroso.', 10.00, 'Bebidas', 'https://i.imgur.com/2Yj88IT.jpg'),
('Dolly Guaraná', 'Refrigerante de guaraná 350ml', 2.50, 'Bebidas', 'assets/images/dollyinho.png');
GO

-- Trigger para atualizar updated_at automaticamente
CREATE TRIGGER tr_usuarios_updated_at
ON usuarios
AFTER UPDATE
AS
BEGIN
    UPDATE usuarios 
    SET updated_at = GETDATE()
    FROM usuarios u
    INNER JOIN inserted i ON u.id = i.id;
END;
GO