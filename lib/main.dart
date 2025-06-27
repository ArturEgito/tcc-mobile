import 'package:flutter/material.dart';
import 'pagina-inicial.dart';
import 'pagamento.dart';
import 'perfil.dart';

void main() {
  runApp(const FinnTechApp());
}

class FinnTechApp extends StatelessWidget {
  const FinnTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinnTech',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const TelaPizzas(),
        '/formas_pagamento': (context) => const FormasPagamentoPage(),
        '/pagamento_dinheiro': (context) => const PagamentoDinheiroPage(),
        '/pagamento_cartao': (context) => const PagamentoCartaoPage(),
        '/pagamento_credito': (context) => const PagamentoCreditoPage(),
        '/pagamento_debito': (context) => const PagamentoDebitoPage(),
        '/pagamento_pix': (context) => const PagamentoPixPage(),
        '/perfil': (context) => ProfilePage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A062F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/tcc.png', height: 250),
            const SizedBox(height: 30),
            const Text(
              'FinnTech',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Transforme seu pedido saudável\nEncontrando os melhores produtos na nossa loja',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFE44C),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Entrar', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Criar conta', style: TextStyle(color: Color(0xFFFFE44C))),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A062F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'Courier')),
                const Text('FinnEat', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                const Text('Bem-vindo de volta!\nEntre com a sua conta para continuar', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 24),
                const Text('E-mail', style: TextStyle(color: Colors.white)),
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Senha', style: TextStyle(color: Colors.white)),
                const TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Senha*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE44C),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Entrar', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text('Esqueceu a senha?', style: TextStyle(color: Color(0xFFFFE44C))),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Cadastre-se', style: TextStyle(color: Color(0xFFFFE44C))),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                const Center(child: Text('Logar com', style: TextStyle(color: Colors.white))),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: Colors.blue),
                    SizedBox(width: 16),
                    Icon(Icons.g_mobiledata, color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A062F),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Criar Conta', style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'Courier')),
                const Text('FinnTech', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                const Text('Nome completo', style: TextStyle(color: Colors.white)),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Seu nome completo*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Email', style: TextStyle(color: Colors.white)),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Celular', style: TextStyle(color: Colors.white)),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Celular*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Senha', style: TextStyle(color: Colors.white)),
                const TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Senha*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Confirme sua senha', style: TextStyle(color: Colors.white)),
                const TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirme sua senha*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (v) {}),
                    const Expanded(child: Text('Li e aceito os termos de uso e a política de privacidade', style: TextStyle(color: Colors.white70))),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE44C),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Cadastrar', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Já possui conta? Entre aqui', style: TextStyle(color: Color(0xFFFFE44C))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A062F),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recuperar senha', style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'Courier')),
                const Text('FinnTech', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                const Text('Esqueci a minha senha', style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 12),
                const Text('Informe o e-mail da sua conta para enviarmos um e-mail para redefinir a sua senha.', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 16),
                const Text('Email', style: TextStyle(color: Colors.white)),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Seu email*',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE44C),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Enviar', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('< Voltar', style: TextStyle(color: Color(0xFFFFE44C))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}