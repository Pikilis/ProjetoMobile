import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/usuario_model.dart';
import 'cadastro_usuario_screen.dart';
import 'cadastro_cliente_screen.dart'; // Exemplo de próxima navegação

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _authService = AuthService();
  String? _erro;

  void _entrar() async {
    final usuario = await _authService.login(
      _usuarioController.text,
      _senhaController.text,
    );

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CadastroClienteScreen()),
      );
    } else {
      setState(() {
        _erro = 'Usuário ou senha inválidos';
      });
    }
  }

  void _irParaCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroUsuarioScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            if (_erro != null)
              Text(_erro!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _entrar, child: const Text('Entrar')),
            TextButton(
              onPressed: _irParaCadastro,
              child: const Text('Cadastrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
