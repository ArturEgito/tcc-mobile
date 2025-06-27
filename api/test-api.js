// Script para testar a API sem banco de dados
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Dados mockados para teste
const produtos = [
  {
    id: 1,
    nome: "Margherita",
    descricao: "Uma pizza clássica com molho de tomate, queijo mussarela e manjericão fresco.",
    preco: 25.00,
    categoria: "Salgadinhos",
    imagem_url: "https://i.imgur.com/0umadnY.jpg"
  },
  {
    id: 2,
    nome: "Pepperoni", 
    descricao: "Deliciosa pizza com molho de tomate, queijo mussarela e fatias de pepperoni crocante.",
    preco: 30.00,
    categoria: "Salgadinhos",
    imagem_url: "https://i.imgur.com/7D6bA2R.jpg"
  },
  {
    id: 3,
    nome: "Sorvete de Chocolate",
    descricao: "Sorvete cremoso de chocolate com pedaços de chocolate.",
    preco: 20.00,
    categoria: "Sorvetes", 
    imagem_url: "https://i.imgur.com/o8cd4Gg.jpg"
  },
  {
    id: 4,
    nome: "Suco de Laranja",
    descricao: "Refresco natural de laranja, fresco e saboroso.",
    preco: 10.00,
    categoria: "Bebidas",
    imagem_url: "https://i.imgur.com/2Yj88IT.jpg"
  }
];

let usuarios = [];
let pedidos = [];

// ROTAS DE TESTE

// Registro
app.post('/api/register', (req, res) => {
  const { nome, email, telefone, senha } = req.body;
  
  if (usuarios.find(u => u.email === email)) {
    return res.status(400).json({ error: 'Email já cadastrado' });
  }
  
  const novoUsuario = {
    id: usuarios.length + 1,
    nome,
    email,
    telefone,
    senha // Em produção, usar bcrypt
  };
  
  usuarios.push(novoUsuario);
  res.status(201).json({ message: 'Usuário criado com sucesso', id: novoUsuario.id });
});

// Login
app.post('/api/login', (req, res) => {
  const { email, senha } = req.body;
  
  const usuario = usuarios.find(u => u.email === email && u.senha === senha);
  
  if (!usuario) {
    return res.status(401).json({ error: 'Credenciais inválidas' });
  }
  
  res.json({ 
    token: 'fake-jwt-token', 
    user: { id: usuario.id, nome: usuario.nome, email: usuario.email } 
  });
});

// Listar produtos
app.get('/api/produtos', (req, res) => {
  const { categoria } = req.query;
  
  if (categoria && categoria !== 'Todas') {
    const produtosFiltrados = produtos.filter(p => p.categoria === categoria);
    return res.json(produtosFiltrados);
  }
  
  res.json(produtos);
});

// Criar pedido
app.post('/api/pedidos', (req, res) => {
  const { produto_id, quantidade = 1, forma_pagamento } = req.body;
  
  const produto = produtos.find(p => p.id === produto_id);
  if (!produto) {
    return res.status(404).json({ error: 'Produto não encontrado' });
  }
  
  const novoPedido = {
    id: pedidos.length + 1,
    produto_id,
    quantidade,
    preco_total: produto.preco * quantidade,
    forma_pagamento,
    numero_atendimento: String(Math.floor(Math.random() * 99) + 1).padStart(2, '0'),
    status: 'pendente'
  };
  
  pedidos.push(novoPedido);
  res.status(201).json({ 
    message: 'Pedido criado com sucesso',
    pedido_id: novoPedido.id,
    numero_atendimento: novoPedido.numero_atendimento
  });
});

// Status da API
app.get('/api/status', (req, res) => {
  res.json({ 
    status: 'API funcionando!',
    usuarios: usuarios.length,
    produtos: produtos.length,
    pedidos: pedidos.length
  });
});

app.listen(PORT, () => {
  console.log(`🚀 API de teste rodando em http://localhost:${PORT}`);
  console.log(`📊 Status: http://localhost:${PORT}/api/status`);
  console.log(`🛍️  Produtos: http://localhost:${PORT}/api/produtos`);
});