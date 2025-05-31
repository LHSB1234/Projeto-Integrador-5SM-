import 'dart:io';
import 'package:adc/src/ui/pages/config.dart';
import 'package:adc/src/ui/pages/perfil_page.dart';
import 'package:flutter/material.dart';
import 'vehicle_register_page.dart';
import 'checklist_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String? _lastCarImagePath;

void _onItemTapped(int index) async {
  if (index == 1) {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VehicleRegisterPage()),
    );

    if (result != null && result is String) {
      setState(() {
        _lastCarImagePath = result;
      });
    }
  } else if (index == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PerfilPage()),
    );
  } else if (index == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  } else {
    setState(() {
      _selectedIndex = index;
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4E58),
      appBar: AppBar(
        title: const Text("A.D.C - Antes de Dirigir Check ✔"),
        centerTitle: true,
        leading: const Icon(Icons.check_box),
        backgroundColor: const Color(0xFF0f6b79),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Showroom circular com imagem do carro
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
                child: _lastCarImagePath != null
                    ? Image.file(File(_lastCarImagePath!), fit: BoxFit.cover)
                    : Image.asset('assets/carros/parati.png', fit: BoxFit.contain),
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF0f6b79),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.car_crash_outlined), label: "Seu Carro"),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "Ajuda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Configurações"),
        ],
      ),
    );
  }
}
