import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CarRegisterPage extends StatefulWidget {
  const CarRegisterPage({super.key});

  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  final _nomeFantasiaController = TextEditingController();

  String? selectedMarca;
  String? selectedModelo;
  String? selectedAno;

  String searchMarca = '';
  String searchModelo = '';

  List<Map<String, String>> marcas = [];
  List<Map<String, String>> modelos = [];
  List<Map<String, String>> anos = [];

  @override
  void initState() {
    super.initState();
    fetchMarcas();
  }

  Future<void> fetchMarcas() async {
    final response = await http.get(
      Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        marcas = data.map<Map<String, String>>((e) {
          return {'codigo': e['codigo'].toString(), 'nome': e['nome']};
        }).toList();
      });
    }
  }

  Future<void> fetchModelos(String marcaCodigo) async {
    final response = await http.get(
      Uri.parse(
          'https://parallelum.com.br/fipe/api/v1/carros/marcas/$marcaCodigo/modelos'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List modelosData = data['modelos'];
      setState(() {
        modelos = modelosData.map<Map<String, String>>((e) {
          return {'codigo': e['codigo'].toString(), 'nome': e['nome']};
        }).toList();
        selectedModelo = null;
        selectedAno = null;
        anos = [];
      });
    }
  }

  Future<void> fetchAnos(String marcaCodigo, String modeloCodigo) async {
    final response = await http.get(
      Uri.parse(
          'https://parallelum.com.br/fipe/api/v1/carros/marcas/$marcaCodigo/modelos/$modeloCodigo/anos'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        anos = data.map<Map<String, String>>((e) {
          return {'codigo': e['codigo'].toString(), 'nome': e['nome']};
        }).toList();
      });
    }
  }

  void _saveCar() {
    if (selectedMarca != null &&
        selectedModelo != null &&
        selectedAno != null) {
      final carInfo = {
        'nomeFantasia': _nomeFantasiaController.text,
        'marca':
            marcas.firstWhere((e) => e['codigo'] == selectedMarca)['nome'] ??
                '',
        'modelo':
            modelos.firstWhere((e) => e['codigo'] == selectedModelo)['nome'] ??
                '',
        'ano': anos.firstWhere((e) => e['codigo'] == selectedAno)['nome'] ?? '',
      };

      debugPrint('Carro salvo: $carInfo');

      // 👉 Navega direto para a tela de checklist/manutenção
      context.go('/car');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar marcas e modelos
    final marcasFiltradas = marcas
        .where(
            (e) => e['nome']!.toLowerCase().contains(searchMarca.toLowerCase()))
        .toList();

    final modelosFiltrados = modelos
        .where((e) =>
            e['nome']!.toLowerCase().contains(searchModelo.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro do Carro'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome Fantasia
            TextField(
              controller: _nomeFantasiaController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome Fantasia (Opcional)',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
            ),
            const SizedBox(height: 16),

            // 🔍 Campo de busca Marca
            TextField(
              onChanged: (value) => setState(() => searchMarca = value),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Pesquisar Marca',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
            ),
            const SizedBox(height: 8),

            // Dropdown Marca
            DropdownButtonFormField<String>(
              value: selectedMarca,
              dropdownColor: Colors.grey[900],
              decoration: const InputDecoration(
                labelText: 'Marca',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
              items: marcasFiltradas
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '',
                            style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMarca = value;
                  selectedModelo = null;
                  selectedAno = null;
                  modelos = [];
                  anos = [];
                  searchModelo = '';
                });
                if (value != null) fetchModelos(value);
              },
            ),
            const SizedBox(height: 16),

            // 🔍 Campo de busca Modelo
            TextField(
              onChanged: (value) => setState(() => searchModelo = value),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Pesquisar Modelo',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
            ),
            const SizedBox(height: 8),

            // Dropdown Modelo
            DropdownButtonFormField<String>(
              value: selectedModelo,
              dropdownColor: Colors.grey[900],
              decoration: const InputDecoration(
                labelText: 'Modelo',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
              items: modelosFiltrados
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '',
                            style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedModelo = value;
                  selectedAno = null;
                  anos = [];
                });
                if (value != null && selectedMarca != null) {
                  fetchAnos(selectedMarca!, value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Dropdown Ano
            DropdownButtonFormField<String>(
              value: selectedAno,
              dropdownColor: Colors.grey[900],
              decoration: const InputDecoration(
                labelText: 'Ano',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
              items: anos
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '',
                            style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAno = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // 🔥 Botão Salvar
            Center(
              child: ElevatedButton(
                onPressed: _saveCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: const Text('Salvar e Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
