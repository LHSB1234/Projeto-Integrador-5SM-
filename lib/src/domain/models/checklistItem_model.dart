import 'package:flutter/material.dart';

class ChecklistItem {
  final String title;
  final IconData icon;
  bool? status; // null = não respondido, true = ok, false = problema
  String? value;

  ChecklistItem({
    required this.title,
    required this.icon,
    this.status,
  });
}
