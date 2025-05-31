import 'package:adc/src/ui/_core/app_colors2.dart';
// ignore: unused_import
import 'package:adc/src/ui/_core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f6b79),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Image.asset('assets/banners/Logo_ADC_Semfundo.png', width: 192),
                  const SizedBox(height: 30),
                  const Text(
                    "Preencha os campos abaixo para criar sua conta.",
                    style: TextStyle(color: Color.fromARGB(255, 197, 197, 197), fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Nome completo",
                    placeholderStyle: const TextStyle(color: Color.fromARGB(255, 197, 197, 197), fontSize: 14),
                    style: const TextStyle(color: Color.fromARGB(221, 222, 221, 221), fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Digite o seu e-mail",
                    placeholderStyle: const TextStyle(color: Color.fromARGB(255, 197, 197, 197), fontSize: 14),
                    style: const TextStyle(color: Color.fromARGB(221, 222, 221, 221), fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Crie uma senha",
                    obscureText: true,
                    placeholderStyle: const TextStyle(color: Color.fromARGB(255, 197, 197, 197), fontSize: 14),
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70, width: 0.8),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CupertinoButton(
                        child: const Text(
                          "Registrar",
                          style: TextStyle(
                            color: Color.fromARGB(255, 197, 197, 197),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          context.go('/'); // Redireciona para home após cadastro
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Já possui uma conta?',
                          style: TextStyle(color: Colors.black87, fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          context.go('/login'); // Redireciona para login
                        },
                        child: const Text('Entrar',
                            style: TextStyle(
                                color: Cores.CorDeDestaque, fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
