import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f6b79),  // COR DE FUNDO ADICIONADA
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: const Color(0xFF0f6b79),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.settings,
                size: 80,
                color: Colors.white,  // Ajustei a cor para branco para contrastar melhor
              ),
              const SizedBox(height: 20),
              const Text(
                'Configurações do Aplicativo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,  // Texto branco para contraste
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock),
                label: const Text('Alterar Senha'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,  // Botão branco para destacar
                  foregroundColor: const Color(0xFF0f6b79), // Texto e ícone na cor principal
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Adicione a lógica para alterar senha aqui
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                icon: const Icon(Icons.info_outline),
                label: const Text('Sobre o App'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0f6b79),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Adicione a navegação para tela Sobre aqui
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
