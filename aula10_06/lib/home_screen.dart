import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'Database.dart';
import 'ServiceOrder.dart';
import 'cadastro_order_modal.dart';
import 'client_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Database _db = Database();
  List<ServiceOrder> _serviceOrders = [];

  @override
  void initState() {
    super.initState();
    _serviceOrders = _db.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menu Hamburguer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.build_circle_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'TechService',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Rota Painel de Atividades
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Atividades'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            // Rota Painel de Clientes
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Painel de Clientes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientScreen()),
                );
              },
            ),
            const Divider(),
            // Sair
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TechService Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        // Removi o botão logout daqui — agora está no drawer
      ),
      // O resto do body é igual ao seu código original
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel de Atividades',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Olá, Técnico. Veja os seus chamados para hoje:'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _serviceOrders.length,
                itemBuilder: (context, index) {
                  final os = _serviceOrders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        os.status == 'Concluída'
                            ? Icons.check_circle
                            : os.status == 'Em Andamento'
                            ? Icons.pending
                            : Icons.error_outline,
                        color: os.status == 'Concluída'
                            ? Colors.green
                            : os.status == 'Em Andamento'
                            ? Colors.orange
                            : Colors.red,
                      ),
                      title: Text(
                        '${os.id} - ${os.client}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(os.desc),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          os.status,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // FloatingActionButton igual ao seu código original
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ServiceOrder? novaOS = await showModalBottomSheet<ServiceOrder>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const CadastroOrderModal(),
          );

          if (novaOS != null) {
            print('Nova OS recebida: ${novaOS.client}');

            setState(() {
              _db.addOrder(novaOS);
              _serviceOrders = _db.getOrders();
            });

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ordem de serviço salva com sucesso!'),
                ),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
