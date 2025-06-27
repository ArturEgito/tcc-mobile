import 'package:flutter/material.dart';

class TelaPizzas extends StatefulWidget {
  const TelaPizzas({super.key});

  @override
  _TelaPizzasState createState() => _TelaPizzasState();
}

class _TelaPizzasState extends State<TelaPizzas> {
  String selectedCategory = 'Todas';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredPizzas = pizzas
        .where((pizza) =>
            (selectedCategory == 'Todas' || pizza.categoria == selectedCategory) &&
            (pizza.nome.toLowerCase().contains(searchQuery.toLowerCase())))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: searchQuery.isNotEmpty ? Colors.blue : Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: TextField(
              onChanged: (query) {
                setState(() => searchQuery = query);
              },
              decoration: const InputDecoration(
                labelText: 'Pesquisar produtos...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, '/perfil'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrinho de compras!')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterButton(
                      label: 'Todas',
                      isSelected: selectedCategory == 'Todas',
                      onTap: () => setState(() => selectedCategory = 'Todas'),
                    ),
                    FilterButton(
                      label: 'Bebidas',
                      isSelected: selectedCategory == 'Bebidas',
                      onTap: () => setState(() => selectedCategory = 'Bebidas'),
                    ),
                    FilterButton(
                      label: 'Salgadinhos',
                      isSelected: selectedCategory == 'Salgadinhos',
                      onTap: () => setState(() => selectedCategory = 'Salgadinhos'),
                    ),
                    FilterButton(
                      label: 'Sorvetes',
                      isSelected: selectedCategory == 'Sorvetes',
                      onTap: () => setState(() => selectedCategory = 'Sorvetes'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredPizzas.length,
                  itemBuilder: (context, index) {
                    final pizza = filteredPizzas[index];
                    return PizzaCard(pizza: pizza);
                  },
                ),
              ),
              const MeiaLuaCarrinho(),
            ],
          ),
        ),
      ),
    );
  }
}

class Pizza {
  final String nome;
  final String imagemUrl;
  final double preco;
  final String descricao;
  final String categoria;

  Pizza({
    required this.nome,
    required this.imagemUrl,
    required this.preco,
    required this.descricao,
    required this.categoria,
  });
}

final List<Pizza> pizzas = [
  Pizza(
    nome: "Margherita",
    imagemUrl: "https://i.imgur.com/0umadnY.jpg",
    preco: 25.0,
    descricao: "Uma pizza clássica com molho de tomate, queijo mussarela e manjericão fresco.",
    categoria: "Salgadinhos",
  ),
  Pizza(
    nome: "Pepperoni",
    imagemUrl: "https://i.imgur.com/7D6bA2R.jpg",
    preco: 30.0,
    descricao: "Deliciosa pizza com molho de tomate, queijo mussarela e fatias de pepperoni crocante.",
    categoria: "Salgadinhos",
  ),
  Pizza(
    nome: "Sorvete de Chocolate",
    imagemUrl: "https://i.imgur.com/o8cd4Gg.jpg",
    preco: 20.0,
    descricao: "Sorvete cremoso de chocolate com pedaços de chocolate.",
    categoria: "Sorvetes",
  ),
  Pizza(
    nome: "Suco de Laranja",
    imagemUrl: "https://i.imgur.com/2Yj88IT.jpg",
    preco: 10.0,
    descricao: "Refresco natural de laranja, fresco e saboroso.",
    categoria: "Bebidas",
  ),
];

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isSelected ? 4 : 0,
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}

class PizzaCard extends StatelessWidget {
  final Pizza pizza;

  const PizzaCard({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PizzaDetailScreen(pizza: pizza)),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                pizza.imagemUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pizza.nome,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "R\$ ${pizza.preco.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('Pedir'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/formas_pagamento');
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PizzaDetailScreen extends StatelessWidget {
  final Pizza pizza;

  const PizzaDetailScreen({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pizza.nome),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(pizza.imagemUrl),
            const SizedBox(height: 16),
            Text(
              pizza.nome,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              pizza.descricao,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Text(
              "R\$ ${pizza.preco.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Você adicionou ${pizza.nome} ao pedido!')),
                );
              },
              child: const Text("Adicionar ao Pedido"),
            ),
          ],
        ),
      ),
    );
  }
}

class MeiaLuaCarrinho extends StatelessWidget {
  const MeiaLuaCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 200),
      painter: MeiaLuaPainter(),
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Carrinho de compras!')),
            );
          },
        ),
      ),
    );
  }
}

class MeiaLuaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue[800]!
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, size.height - 60, size.width, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
