const express = require('express');
const sql = require('mssql');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());

// Configuração do SQL Server
const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_HOST,
  database: process.env.DB_NAME,
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

// Conectar ao SQL Server
sql.connect(config).then(() => {
  console.log('Conectado ao SQL Server');
}).catch(err => {
  console.error('Erro ao conectar:', err);
});

// Middleware de autenticação
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Token de acesso requerido' });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: 'Token inválido' });
    req.user = user;
    next();
  });
};

// ROTAS

// Registro de usuário
app.post('/api/register', async (req, res) => {
  const { nome, email, telefone, senha } = req.body;
  
  try {
    const hashedPassword = await bcrypt.hash(senha, 10);
    const request = new sql.Request();
    
    const result = await request
      .input('nome', sql.NVarChar, nome)
      .input('email', sql.NVarChar, email)
      .input('telefone', sql.NVarChar, telefone)
      .input('senha', sql.NVarChar, hashedPassword)
      .query('INSERT INTO usuarios (nome, email, telefone, senha) OUTPUT INSERTED.id VALUES (@nome, @email, @telefone, @senha)');
    
    res.status(201).json({ message: 'Usuário criado com sucesso', id: result.recordset[0].id });
  } catch (error) {
    if (error.number === 2627) {
      return res.status(400).json({ error: 'Email já cadastrado' });
    }
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// Login
app.post('/api/login', async (req, res) => {
  const { email, senha } = req.body;
  
  try {
    const request = new sql.Request();
    const result = await request
      .input('email', sql.NVarChar, email)
      .query('SELECT * FROM usuarios WHERE email = @email');
    
    if (result.recordset.length === 0) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }
    
    const user = result.recordset[0];
    const validPassword = await bcrypt.compare(senha, user.senha);
    
    if (!validPassword) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }
    
    const token = jwt.sign({ id: user.id, email: user.email }, process.env.JWT_SECRET);
    res.json({ token, user: { id: user.id, nome: user.nome, email: user.email } });
  } catch (error) {
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// Listar produtos
app.get('/api/produtos', async (req, res) => {
  const { categoria } = req.query;
  
  try {
    const request = new sql.Request();
    let query = 'SELECT * FROM produtos WHERE ativo = 1';
    
    if (categoria && categoria !== 'Todas') {
      query += ' AND categoria = @categoria';
      request.input('categoria', sql.NVarChar, categoria);
    }
    
    const result = await request.query(query);
    res.json(result.recordset);
  } catch (error) {
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// Criar pedido
app.post('/api/pedidos', authenticateToken, async (req, res) => {
  const { produto_id, quantidade, forma_pagamento } = req.body;
  const usuario_id = req.user.id;
  
  try {
    const request = new sql.Request();
    
    // Buscar preço do produto
    const produtoResult = await request
      .input('produto_id', sql.Int, produto_id)
      .query('SELECT preco FROM produtos WHERE id = @produto_id');
    
    if (produtoResult.recordset.length === 0) {
      return res.status(404).json({ error: 'Produto não encontrado' });
    }
    
    const preco_total = produtoResult.recordset[0].preco * quantidade;
    const numero_atendimento = String(Math.floor(Math.random() * 99) + 1).padStart(2, '0');
    
    const pedidoResult = await request
      .input('usuario_id', sql.Int, usuario_id)
      .input('quantidade', sql.Int, quantidade)
      .input('preco_total', sql.Decimal(10,2), preco_total)
      .input('forma_pagamento', sql.NVarChar, forma_pagamento)
      .input('numero_atendimento', sql.NVarChar, numero_atendimento)
      .query('INSERT INTO pedidos (usuario_id, produto_id, quantidade, preco_total, forma_pagamento, numero_atendimento) OUTPUT INSERTED.id VALUES (@usuario_id, @produto_id, @quantidade, @preco_total, @forma_pagamento, @numero_atendimento)');
    
    res.status(201).json({ 
      message: 'Pedido criado com sucesso', 
      pedido_id: pedidoResult.recordset[0].id,
      numero_atendimento 
    });
  } catch (error) {
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// Atualizar perfil
app.put('/api/perfil', authenticateToken, async (req, res) => {
  const { nome, telefone, avatar_index } = req.body;
  const usuario_id = req.user.id;
  
  try {
    const request = new sql.Request();
    await request
      .input('nome', sql.NVarChar, nome)
      .input('telefone', sql.NVarChar, telefone)
      .input('avatar_index', sql.Int, avatar_index)
      .input('usuario_id', sql.Int, usuario_id)
      .query('UPDATE usuarios SET nome = @nome, telefone = @telefone, avatar_index = @avatar_index WHERE id = @usuario_id');
    
    res.json({ message: 'Perfil atualizado com sucesso' });
  } catch (error) {
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

// Buscar perfil
app.get('/api/perfil', authenticateToken, async (req, res) => {
  const usuario_id = req.user.id;
  
  try {
    const request = new sql.Request();
    const result = await request
      .input('usuario_id', sql.Int, usuario_id)
      .query('SELECT id, nome, email, telefone, avatar_index FROM usuarios WHERE id = @usuario_id');
    
    if (result.recordset.length === 0) {
      return res.status(404).json({ error: 'Usuário não encontrado' });
    }
    
    res.json(result.recordset[0]);
  } catch (error) {
    res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});