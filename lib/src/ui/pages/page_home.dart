import 'package:adc/src/ui/_core/widgets/my_appbar.dart';
import 'package:adc/src/ui/_core/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'checklist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  double checklistProgress = 0.10; // Exemplo: 60% do checklist concluído
  String carName = 'Parati Surf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4E58),
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título com o nome do carro
            Text(
              carName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Velocímetro (barra circular de progresso)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 260,
                  height: 260,
                  child: CircularProgressIndicator(
                    value: checklistProgress,
                    strokeWidth: 12,
                    backgroundColor: const Color.fromARGB(255, 199, 30, 30),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 217, 238, 242),
                    ),
                  ),
                ),
                // Imagem do carro no meio do círculo
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF083E47),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/carros/parati.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Botão para o checklist
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 217, 238, 242),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChecklistPage()),
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
