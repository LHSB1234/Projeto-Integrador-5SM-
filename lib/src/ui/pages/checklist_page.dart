import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // Lista de itens com seus estados (null = não respondido, true = ok, false = problema)
  final List<Map<String, dynamic>> checklist = [
    {'title': 'Pressão dos pneus', 'status': null, 'icon': Icons.tire_repair},
    {'title': 'Nível do óleo', 'status': null, 'icon': Icons.oil_barrel},
    {'title': 'Pneus carecas', 'status': null, 'icon': Icons.warning_amber},
    {'title': 'Luzes funcionando', 'status': null, 'icon': Icons.lightbulb},
    {
      'title': 'Freios respondendo bem',
      'status': null,
      'icon': Icons.directions_car
    },
    {'title': 'Documentação em dia', 'status': null, 'icon': Icons.description},
    {
      'title': 'Limpador de para-brisa',
      'status': null,
      'icon': Icons.water_drop
    },
    {
      'title': 'Combustível suficiente',
      'status': null,
      'icon': Icons.local_gas_station
    },
    {'title': 'Estepe e Ferramentas', 'status': null, 'icon': Icons.handyman},
  ];

  void updateStatus(int index, bool status) {
    setState(() {
      checklist[index]['status'] = status;
    });
  }

  Future<void> _abrirSugestoesDePneus() async {
    final url =
        Uri.parse('https://www.google.com/search?tbm=shop&q=compra+pneu+carro');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir o navegador.';
    }
  }

  void _showSuccessDialogAndReturnHome() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0f6b79),
        title: const Text("Checklist Concluído ✅",
            style: TextStyle(color: Colors.white)),
        content: const Text(
          "Parabéns! Você está pronto para dirigir com segurança!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop(); // Fecha o dialog
      Navigator.of(context).pop(); // Retorna para a Home
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4E58),
      appBar: AppBar(
        title: const Text("Checklist de Segurança"),
        backgroundColor: const Color(0xFF0f6b79),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: checklist.length,
              itemBuilder: (context, index) {
                final item = checklist[index];
                Color? tileColor;

                if (item['status'] == true) {
                  tileColor = Colors.green.withOpacity(0.2);
                } else if (item['status'] == false) {
                  tileColor = Colors.red.withOpacity(0.2);
                }

                return Card(
                  color: tileColor ?? const Color(0xFF083E47),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(item['icon'], color: Colors.white),
                    title: Text(
                      item['title'],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green),
                          onPressed: () => updateStatus(index, true),
                          tooltip: 'Está OK',
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            updateStatus(index, false);

                            // Verifica se o item é "Pneus carecas"
                            if (checklist[index]['title'] == 'Pneus carecas') {
                              // Exibe o popup com sugestões de pneus
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    true, // Pode fechar o popup clicando fora
                                builder: (context) => AlertDialog(
                                  backgroundColor: const Color(0xFF0f6b79),
                                  title: const Text(
                                    "Pneus Carecas Detectados!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Parece que seus pneus estão carecas! Não se preocupe, temos uma sugestão para você.",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed:
                                            _abrirSugestoesDePneus, // Função que abre o Google Shopping
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange, // Cor do botão
                                        ),
                                        child: const Text(
                                          "Ver Pneus no Google Shopping",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          tooltip: 'Há um problema',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton.icon(
              onPressed: _showSuccessDialogAndReturnHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 217, 238, 242),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              icon: const Icon(Icons.check),
              label: const Text("Concluir Checklist"),
            ),
          ),
        ],
      ),
    );
  }
}
