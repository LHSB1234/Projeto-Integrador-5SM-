import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});
static const _routes = [
    '/',
    '/car',
    '/reportscreen',
    '/profile',
    '/settings'
  ];

  final Color primaryColor = const Color(0xFF0A4E58);
  final Color secondaryColor = const Color(0xFF083E47);
  final Color accentColor = const Color.fromARGB(255, 217, 238, 242);

  int getCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context).routerDelegate.currentConfiguration;
    final String location = route.uri.toString();
    final index = _routes.indexOf(location);
    return index >= 0 ? index : 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4E58),
      appBar: AppBar(
  backgroundColor: const Color(0xFF0f6b79),
  title: const Text('Seu Perfil'),
  centerTitle: true,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      context.go('/');
    },
  ),
),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto do usuário
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/usuario_padrao.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Nome
              const Text(
                "João Victor",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Telefone
              const Text(
                "(11) 99654-4583",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              // Email
              const Text(
                "joaovictor@gmail.com",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 32),

              // Botão Editar
              ElevatedButton.icon(
                onPressed: () {
                  // ação futura para editar
                },
                icon: const Icon(Icons.edit),
                label: const Text("Editar Perfil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0f6b79),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
