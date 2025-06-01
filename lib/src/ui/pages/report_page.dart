import 'package:adc/src/ui/_core/widgets/my_appbar.dart'; // Importe sua AppBar customizada
import 'package:adc/src/ui/_core/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  static const _routes = [
    '/',
    '/car',
    '/reportscreen',
    '/profile',
    '/settings'
  ];

  // Cores padronizadas
  final Color primaryColor = const Color(0xFF0A4E58); // Cor principal do tema
  final Color secondaryColor =
      const Color(0xFF083E47); // Cor secundária para elementos (fundo de cards)
  final Color accentColor =
      const Color.fromARGB(255, 217, 238, 242); // Cor de destaque

  int getCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context).routerDelegate.currentConfiguration;
    final String location =
        route.uri.toString(); // Pega a rota atual como string
    final index = _routes.indexOf(location);
    return index >= 0 ? index : 0;
  }

  // Exemplo de dados mockados para o relatório
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
        "Data: 2025-05-26, Viagem: 95km, Consumo: 8.5L",
        "Data: 2025-05-25, Viagem: 60km, Consumo: 5L",
        "Data: 2025-05-24, Viagem: 150km, Consumo: 13L",
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(), // Usando sua AppBar customizada
      backgroundColor: primaryColor, // Fundo do Scaffold com a cor principal
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    accentColor), // Cor do indicador de progresso
              ),
            )
          : _reportData.isEmpty
              ? Center(
                  child: Text(
                    "Nenhum dado de relatório encontrado.",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18), // Estilo para texto de dados vazios
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20.0), // Aumenta o padding da lista
                  itemCount: _reportData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15.0), // Aumenta o espaçamento entre os cards
                      elevation: 4, // Sombra para o Card
                      color: secondaryColor, // Fundo do Card com a cor secundária
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Bordas arredondadas
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0), // Aumenta o padding interno do card
                        child: Text(
                          _reportData[index],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white), // Texto do relatório em branco
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: MyNavigationBar(
        currentIndex: getCurrentIndex(context),
      ),
    );
  }
}