import 'package:adc/src/ui/_core/widgets/my_appbar.dart';
import 'package:adc/src/ui/_core/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'checklist_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key}); // Construtor const recomendado para StatefulWidget

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex =
      0; // variável de estado deve ficar na State, não no Widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4E58), // Cor um pouco mais escura
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagem do carro circular
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF083E47),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: ClipOval(
                child: Image.asset(
                  'assets/carros/parati.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Botão para a página de checklist
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 217, 238, 242),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChecklistPage()),
                );
              },
              icon: const Icon(Icons.checklist),
              label: const Text("Ir para o Checklist"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }
}
