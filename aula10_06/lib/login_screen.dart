import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _doLogin() {
    // Simulação simples de validação
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Melhores Práticas: Limpa a pilha de rotas para que o
      // utilizador não volte ao Login pelo botão "Voltar"
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.build_circle_outlined,
                size: 80,
                color: Color(0xFF1E3A8A),
              ), // Icon
              const SizedBox(height: 16),
              const Text(
                'TechService',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ), // TextStyle
              ), // Text
              const Text(
                'Gestão de Ordens de Serviço',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ), // Text
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail ou Matrícula',
                  prefixIcon: Icon(Icons.person),
                ), // InputDecoration
                keyboardType: TextInputType.emailAddress,
              ), // TextField
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ), // InputDecoration
                obscureText: true,
              ), // TextField
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _doLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Entrar', style: TextStyle(fontSize: 16)),
              ), // ElevatedButton
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navegação comum: Adiciona a tela de cadastro no topo da pilha
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ), // MaterialPageRoute
                  );
                },
                child: const Text('Não tem uma conta? Cadastre-se'),
              ), // TextButton
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Center
    ); // Scaffold
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
