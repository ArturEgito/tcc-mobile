-- Banco de dados FinnTech
CREATE DATABASE IF NOT EXISTS finntech;
USE finntech;

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    senha VARCHAR(255) NOT NULL,
    avatar_index INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    imagem_url VARCHAR(500),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    produto_id INT,
    quantidade INT DEFAULT 1,
    preco_total DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('dinheiro', 'credito', 'debito', 'pix') NOT NULL,
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    numero_atendimento VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserir produtos iniciais
INSERT INTO produtos (nome, descricao, preco, categoria, imagem_url) VALUES
('Margherita', 'Uma pizza clássica com molho de tomate, queijo mussarela e manjericão fresco.', 25.00, 'Salgadinhos', 'https://i.imgur.com/0umadnY.jpg'),
('Pepperoni', 'Deliciosa pizza com molho de tomate, queijo mussarela e fatias de pepperoni crocante.', 30.00, 'Salgadinhos', 'https://i.imgur.com/7D6bA2R.jpg'),
('Sorvete de Chocolate', 'Sorvete cremoso de chocolate com pedaços de chocolate.', 20.00, 'Sorvetes', 'https://i.imgur.com/o8cd4Gg.jpg'),
('Suco de Laranja', 'Refresco natural de laranja, fresco e saboroso.', 10.00, 'Bebidas', 'https://i.imgur.com/2Yj88IT.jpg'),
('Dolly Guaraná', 'Refrigerante de guaraná 350ml', 2.50, 'Bebidas', 'assets/images/dollyinho.png');