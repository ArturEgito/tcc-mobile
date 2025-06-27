# FinnTech API

API REST para o aplicativo FinnTech desenvolvida em Node.js com MySQL.

## Instalação

1. Instalar dependências:
```bash
cd api
npm install
```

2. Configurar banco de dados:
- Instalar MySQL
- Executar o script `database.sql` para criar as tabelas
- Configurar credenciais no arquivo `.env`

3. Executar a API:
```bash
npm run dev
```

## Endpoints

### Autenticação
- `POST /api/register` - Registrar usuário
- `POST /api/login` - Login

### Produtos
- `GET /api/produtos` - Listar produtos
- `GET /api/produtos?categoria=Bebidas` - Filtrar por categoria

### Pedidos
- `POST /api/pedidos` - Criar pedido (requer autenticação)

### Perfil
- `GET /api/perfil` - Buscar perfil (requer autenticação)
- `PUT /api/perfil` - Atualizar perfil (requer autenticação)

## Banco de Dados

### Tabelas:
- `usuarios` - Dados dos usuários
- `produtos` - Catálogo de produtos
- `pedidos` - Histórico de pedidos