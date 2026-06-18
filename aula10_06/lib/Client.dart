class Client {
  final int id;
  final String nome;
  final String telefone;
  final String email;

  Client({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });

  @override
  String toString() => 'Client(id: $id, nome: $nome)';
}
