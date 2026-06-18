import 'package:flutter/material.dart';
import 'Database.dart';
import 'Client.dart';
import 'cadastro_client.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Database _db = Database();
  List<Client> _clients = [];

  @override
  void initState() {
    super.initState();
    _clients = _db.getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Clientes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clientes Cadastrados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _clients.length,
                itemBuilder: (context, index) {
                  final client = _clients[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                        client.nome,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 14),
                              const SizedBox(width: 4),
                              Text(client.telefone),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email, size: 14),
                              const SizedBox(width: 4),
                              Text(client.email),
                            ],
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.favorite_border),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Client? novoCliente = await showModalBottomSheet<Client>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const CadastroClientModal(),
          );

          if (novoCliente != null) {
            setState(() {
              _db.addClient(novoCliente);
              _clients = _db.getClients();
            });

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cliente salvo com sucesso!')),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}