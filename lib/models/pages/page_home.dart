import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A.D.C - Antes de Dirigir Check ✔"),
        centerTitle: true,
        leading: Icon(Icons.check_box),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        child: Text(
          "Exemplo de texto",
          style: TextStyle(fontSize: 30),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash_outlined), label: "Seu Carro"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: "Ajuda"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Configurações"),
          ]),
    );
  }
}
