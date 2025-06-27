const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Dados em memória para teste
let usuarios = [];
let produtos = [
  { id: 1, nome: "Margherita", preco: 25.00, categoria: "Salgadinhos", imagem_url: "https://i.imgur.com/0umadnY.jpg" },
  { id: 2, nome: "Pepperoni", preco: 30.00, categoria: "Salgadinhos", imagem_url: "https://i.imgur.com/7D6bA2R.jpg" },
  { id: 3, nome: "Sorvete de Chocolate", preco: 20.00, categoria: "Sorvetes", imagem_url: "https://i.imgur.com/o8cd4Gg.jpg" },
  { id: 4, nome: "Suco de Laranja", preco: 10.00, categoria: "Bebidas", imagem_url: "https://i.imgur.com/2Yj88IT.jpg" }
];
let pedidos = [];

// Status da API
app.get('/api/status', (req, res) => {
  res.json({ status: 'API funcionando!', produtos: produtos.length });
});

// Listar produtos
app.get('/api/produtos', (req, res) => {
  const { categoria } = req.query;
  if (categoria && categoria !== 'Todas') {
    return res.json(produtos.filter(p => p.categoria === categoria));
  }
  res.json(produtos);
});

// Registrar usuário
app.post('/api/register', (req, res) => {
  const { nome, email, senha } = req.body;
  
  if (usuarios.find(u => u.email === email)) {
    return res.status(400).json({ error: 'Email já cadastrado' });
  }
  
  const novoUsuario = { id: usuarios.length + 1, nome, email, senha };
  usuarios.push(novoUsuario);
  res.status(201).json({ message: 'Usuário criado', id: novoUsuario.id });
});

// Login
app.post('/api/login', (req, res) => {
  const { email, senha } = req.body;
  const usuario = usuarios.find(u => u.email === email && u.senha === senha);
  
  if (!usuario) {
    return res.status(401).json({ error: 'Credenciais inválidas' });
  }
  
  res.json({ token: 'fake-token', user: { id: usuario.id, nome: usuario.nome } });
});

// Criar pedido
app.post('/api/pedidos', (req, res) => {
  const { produto_id, forma_pagamento } = req.body;
  const produto = produtos.find(p => p.id === produto_id);
  
  if (!produto) {
    return res.status(404).json({ error: 'Produto não encontrado' });
  }
  
  const pedido = {
    id: pedidos.length + 1,
    produto_id,
    forma_pagamento,
    numero_atendimento: String(Math.floor(Math.random() * 99) + 1).padStart(2, '0')
  };
  
  pedidos.push(pedido);
  res.status(201).json({ message: 'Pedido criado', numero_atendimento: pedido.numero_atendimento });
});

app.listen(PORT, () => {
  console.log(`🚀 API rodando em http://localhost:${PORT}`);
  console.log(`📊 Teste: http://localhost:${PORT}/api/status`);
  console.log(`🛍️  Produtos: http://localhost:${PORT}/api/produtos`);
});