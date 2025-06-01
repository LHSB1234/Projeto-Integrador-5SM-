import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importe o go_router

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo as cores para consistência
    final Color primaryColor = const Color(0xFF0A4E58); // Cor principal do tema
    final Color accentColor =
        const Color.fromARGB(255, 217, 238, 242); // Cor de destaque para texto/ícones

    return Scaffold(
      backgroundColor: primaryColor, // Fundo do Scaffold com a cor principal
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(color: Colors.white), // Título em branco
        ),
        backgroundColor: primaryColor, // Cor de fundo da AppBar
        centerTitle: true,
        // Adicionando o botão de voltar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor), // Ícone de seta na cor de destaque
          onPressed: () {
            // ALTURA DA MUDANÇA AQUI:
            context.go('/'); // Navega para a rota principal (Home Page)
            // Se você quiser voltar para a última página visitada APENAS se houver uma,
            // e for uma página "empilhada", você usaria context.pop().
            // Mas para uma tela de configurações top-level de aba, `go('/')` é mais robusto.
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings,
                size: 80,
                color: accentColor, // Ícone na cor de destaque
              ),
              const SizedBox(height: 20),
              Text(
                'Configurações do Aplicativo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: accentColor, // Texto na cor de destaque
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.lock, color: primaryColor), // Ícone na cor principal
                label: Text('Alterar Senha',
                    style: TextStyle(color: primaryColor)), // Texto na cor principal
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor, // Botão na cor de destaque
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                  ),
                ),
                onPressed: () {
                  // Adicione a lógica para alterar senha aqui
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                icon: Icon(Icons.info_outline,
                    color: primaryColor), // Ícone na cor principal
                label: Text('Sobre o App',
                    style: TextStyle(color: primaryColor)), // Texto na cor principal
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor, // Botão na cor de destaque
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                  ),
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