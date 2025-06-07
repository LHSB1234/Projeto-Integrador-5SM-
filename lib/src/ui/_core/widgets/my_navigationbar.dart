import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MyNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  static const List<String> _routes = [
    '/',
    '/registercar',
    '/reportscreen',
    '/profile',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF0f6b79), // cor para o ícone ativo
      unselectedItemColor: Colors.grey, // cor para os inativos
      onTap: (index) {
        if (index >= 0 && index < _routes.length) {
          context.go(_routes[index]);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_crash_outlined),
          label: "Seu Carro",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Relatório",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Configurações",
        ),
      ],
    );
  }
}
