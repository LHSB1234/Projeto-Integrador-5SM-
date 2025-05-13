import 'package:flutter/material.dart';

class Cores {
  static const Color Fundo = Color(0xFF202442);
  static const Color ConstrasteComfundo = Color(0xFF353A61);
  static const Color CorDeDestaque = Color.fromARGB(255, 255, 255, 255);
  static const Color Formularios = Color(0xFF62678C);
}

class EmailCheck {
  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;
  if (timeNow <= 12) {
    return 'Bom dia';
  } else if ((timeNow > 12) && (timeNow <= 18)) {
    return 'Boa tarde';
  } else {
    return 'Boa noite';
  }
}

class Textos {
  static const TextStyle titulos = TextStyle(
    color: Colors.white,
    letterSpacing: 0.5,
    fontSize: 18,
    inherit: true,
  );

  static const TextStyle subtitulos = TextStyle(
    color: Colors.white,
    letterSpacing: 0.5,
    fontSize: 14,
    inherit: true,
  );
}
