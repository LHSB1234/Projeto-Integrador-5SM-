import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("A.D.C - Antes de Dirigir Check ✔"),
      centerTitle: true,
      leading: const Icon(Icons.check_box),
      backgroundColor: const Color(0xFF0f6b79),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
