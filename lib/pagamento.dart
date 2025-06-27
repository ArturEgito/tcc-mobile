import 'package:flutter/material.dart';

// Cores e estilos reutilizáveis
const Color bgColor = Colors.white;
const Color buttonColor = Colors.white;
const TextStyle buttonTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const EdgeInsets cardPadding = EdgeInsets.all(16);

class ProdutoCard extends StatelessWidget {
  final Widget child;
  const ProdutoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: cardPadding,
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Image.asset('assets/images/dollyinho.png', height: 60),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dolly Guaraná (refrigerante)', style: TextStyle(fontSize: 14)),
                  Text('350ml', style: TextStyle(fontSize: 12)),
                  Text('R\$ 2,50', style: titleTextStyle),
                ],
              ),
            ]),
            const SizedBox(height: 16),
            child
          ],
        ),
      ),
    );
  }
}

class VoltarButton extends StatelessWidget {
  const VoltarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}

class FormasPagamentoPage extends StatelessWidget {
  const FormasPagamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/pagamento_dinheiro'),
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.attach_money), SizedBox(width: 8), Text('DINHEIRO', style: buttonTextStyle)],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/pagamento_cartao'),
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.credit_card), SizedBox(width: 8), Text('CARTÃO', style: buttonTextStyle)],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/pagamento_pix'),
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.qr_code), SizedBox(width: 8), Text('PIX', style: buttonTextStyle)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagamentoDinheiroPage extends StatelessWidget {
  const PagamentoDinheiroPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.attach_money), SizedBox(width: 8), Text('DINHEIRO', style: buttonTextStyle)],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Vá até o balcão de pagamento mais próximo e mostre o número de atendimento, e retire o seu produto!',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text('NUMERO: 01', style: titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagamentoCartaoPage extends StatelessWidget {
  const PagamentoCartaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/pagamento_credito'),
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                      child: const Text('CREDITO', style: buttonTextStyle),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/pagamento_debito'),
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                      child: const Text('DÉBITO', style: buttonTextStyle),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagamentoCreditoPage extends StatelessWidget {
  const PagamentoCreditoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: const Column(
                  children: [
                    Text('CREDITO', style: buttonTextStyle),
                    SizedBox(height: 12),
                    Text(
                      'Vá até o balcão de pagamento mais próximo e mostre o número de atendimento, e retire o seu produto!',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text('NUMERO: 01', style: titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagamentoDebitoPage extends StatelessWidget {
  const PagamentoDebitoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: const Column(
                  children: [
                    Text('DÉBITO', style: buttonTextStyle),
                    SizedBox(height: 12),
                    Text(
                      'Vá até o balcão de pagamento mais próximo e mostre o número de atendimento, e retire o seu produto!',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text('NUMERO: 01', style: titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagamentoPixPage extends StatelessWidget {
  const PagamentoPixPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltarButton(),
          Expanded(
            child: Center(
              child: ProdutoCard(
                child: const Column(
                  children: [
                    Text('PIX', style: buttonTextStyle),
                    SizedBox(height: 12),
                    Text('Pix do estabelecimento:\nitbbelva@gmail.com\nou pague pelo link PIX', textAlign: TextAlign.center),
                    SizedBox(height: 12),
                    Text('NUMERO: 01', style: titleTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}