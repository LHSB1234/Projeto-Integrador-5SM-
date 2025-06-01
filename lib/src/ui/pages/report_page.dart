import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // Exemplo de dados mockados para o relatório
  // Em uma aplicação real, você carregaria isso de uma fonte de dados
  List<String> _reportData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReportData();
  }

  Future<void> _loadReportData() async {
    // Simula um carregamento de dados
    await Future.delayed(
        const Duration(seconds: 2)); // Atraso para simular carregamento
    setState(() {
      _reportData = [
        "Data: 2025-05-30, Viagem: 120km, Consumo: 10L",
        "Data: 2025-05-29, Viagem: 80km, Consumo: 7L",
        "Data: 2025-05-28, Viagem: 50km, Consumo: 4L",
        "Data: 2025-05-27, Viagem: 200km, Consumo: 18L",
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relatório de Viagens"),
        backgroundColor: const Color(0xFF0f6b79),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reportData.isEmpty
              ? const Center(
                  child: Text("Nenhum dado de relatório encontrado."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _reportData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _reportData[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
