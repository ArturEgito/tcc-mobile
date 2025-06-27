# Como Testar a API com SQL Server

## 1. Configurar SQL Server Management Studio

### Passo 1: Executar o Script SQL
1. Abra o **SQL Server Management Studio (SSMS)**
2. Conecte-se ao seu servidor SQL Server
3. Abra o arquivo `database-sqlserver.sql`
4. Execute o script completo (F5)

### Passo 2: Verificar se as tabelas foram criadas
```sql
USE finntech;
SELECT * FROM produtos;
SELECT * FROM usuarios;
SELECT * FROM pedidos;
```

## 2. Configurar a API

### Passo 1: Instalar dependências
```bash
cd api
npm install
```

### Passo 2: Configurar .env
Edite o arquivo `.env` com suas credenciais do SQL Server:
```
DB_HOST=localhost
DB_USER=sa
DB_PASSWORD=SuaSenhaDoSQLServer
DB_NAME=finntech
```

### Passo 3: Executar a API
```bash
npm start
```

## 3. Testar os Endpoints

### Usando o navegador:
- Status: http://localhost:3000/api/status
- Produtos: http://localhost:3000/api/produtos

### Usando Postman ou Insomnia:

#### Registrar usuário:
```
POST http://localhost:3000/api/register
Content-Type: application/json

{
  "nome": "João Silva",
  "email": "joao@teste.com",
  "telefone": "11999999999",
  "senha": "123456"
}
```

#### Fazer login:
```
POST http://localhost:3000/api/login
Content-Type: application/json

{
  "email": "joao@teste.com",
  "senha": "123456"
}
```

#### Listar produtos:
```
GET http://localhost:3000/api/produtos
```

#### Filtrar produtos por categoria:
```
GET http://localhost:3000/api/produtos?categoria=Bebidas
```

## 4. Verificar no Banco

Após testar, verifique os dados no SSMS:
```sql
USE finntech;
SELECT * FROM usuarios;
SELECT * FROM produtos;
SELECT * FROM pedidos;
```

## Troubleshooting

### Erro de conexão:
- Verifique se o SQL Server está rodando
- Confirme as credenciais no arquivo `.env`
- Teste a conexão no SSMS primeiro

### Erro de porta:
- Verifique se a porta 3000 está livre
- Mude a porta no arquivo `.env` se necessário