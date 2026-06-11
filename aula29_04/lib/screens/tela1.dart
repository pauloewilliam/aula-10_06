import 'package:flutter/material.dart';

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Tela 1', style: TextStyle(fontSize: 28)),
          Text('Contador: $contador', style: const TextStyle(fontSize: 22)),
          ElevatedButton(
            onPressed: incrementar,
            child: const Text('Incrementar'),
          ),
        ],
      ),
    );
  }
}