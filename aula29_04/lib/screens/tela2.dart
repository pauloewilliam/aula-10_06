import 'package:flutter/material.dart';

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
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
          const Text('Tela 2', style: TextStyle(fontSize: 28)),
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