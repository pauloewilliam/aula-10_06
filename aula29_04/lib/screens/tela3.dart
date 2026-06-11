import 'package:flutter/material.dart';

class Tela3 extends StatefulWidget {
  const Tela3({super.key});

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
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
          const Text('Tela 3', style: TextStyle(fontSize: 28)),
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