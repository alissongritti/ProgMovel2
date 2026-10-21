import 'package:flutter/material.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Participante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaCadastro(),
    );
  }
}

// 2. Classe Participante imutável
class Participante {
  final String email;
  final String nome;
  final String telefone;
  final String cpf;

  const Participante({
    required this.email,
    required this.nome,
    required this.telefone,
    required this.cpf,
  });
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // 3. Chave global e controladores para cada campo
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nomeController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  // Funções de validação individuais
  String? _validarEmail(String? valor) {
    final email = valor?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe o e-mail.';
    }
    final formato = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!formato.hasMatch(email)) {
      return 'Informe um e-mail válido (ex: ana@email.com).';
    }
    return null;
  }

  String? _validarNome(String? valor) {
    final nome = valor?.trim() ?? '';
    if (nome.isEmpty) {
      return 'Informe o nome.';
    }
    if (nome.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres.';
    }
    return null;
  }

  String? _validarTelefone(String? valor) {
    final telefone = valor?.trim() ?? '';
    if (telefone.isEmpty) {
      return 'Informe o telefone.';
    }
    // Formato DD-DDDDD-DDDD (2 dígitos - 5 dígitos - 4 dígitos)
    final formato = RegExp(r'^\d{2}-\d{5}-\d{4}$');
    if (!formato.hasMatch(telefone)) {
      return 'Informe o telefone no formato DD-DDDDD-DDDD.';
    }
    return null;
  }

  String? _validarCpf(String? valor) {
    final cpf = valor?.trim() ?? '';
    if (cpf.isEmpty) {
      return 'Informe o CPF.';
    }
    // Exatamente 11 dígitos numéricos sem pontos ou traço
    final formato = RegExp(r'^\d{11}$');
    if (!formato.hasMatch(cpf)) {
      return 'O CPF deve conter exatamente 11 dígitos numéricos.';
    }
    return null;
  }

  void _exibirResumo() {
    if (_formKey.currentState!.validate()) {
      final participante = Participante(
        email: _emailController.text.trim(),
        nome: _nomeController.text.trim(),
        telefone: _telefoneController.text.trim(),
        cpf: _cpfController.text.trim(),
      );

      FocusScope.of(context).unfocus();

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => TelaResumo(participante: participante),
        ),
      );
    }
  }

  void _limpar() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _nomeController.clear();
    _telefoneController.clear();
    _cpfController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Participante'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo E-mail
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Ex.: ana@email.com',
                  border: OutlineInputBorder(),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),

              // Campo Nome
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Ex.: Ana Souza',
                  border: OutlineInputBorder(),
                ),
                validator: _validarNome,
              ),
              const SizedBox(height: 16),

              // Campo Telefone
              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: '11-98765-4321',
                  border: OutlineInputBorder(),
                ),
                validator: _validarTelefone,
              ),
              const SizedBox(height: 16),

              // Campo CPF
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _exibirResumo(),
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: '12345678901',
                  border: OutlineInputBorder(),
                ),
                validator: _validarCpf,
              ),
              const SizedBox(height: 24),

              // Botões
              ElevatedButton(
                onPressed: _exibirResumo,
                child: const Text('Exibir dados'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _limpar,
                child: const Text('Limpar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Tela de Resumo
class TelaResumo extends StatelessWidget {
  final Participante participante;

  const TelaResumo({
    super.key,
    required this.participante,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Cadastro'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Dados do Participante',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('E-mail: ${participante.email}'),
            const SizedBox(height: 8),
            Text('Nome: ${participante.nome}'),
            const SizedBox(height: 8),
            Text('Telefone: ${participante.telefone}'),
            const SizedBox(height: 8),
            Text('CPF: ${participante.cpf}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar para editar'),
            ),
          ],
        ),
      ),
    );
  }
}