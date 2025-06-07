import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:adc/src/ui/_core/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _saveCar() async {
  if (selectedMarca != null &&
      selectedModelo != null &&
      selectedAno != null) {
    final carInfo = {
      'nomeFantasia': _nomeFantasiaController.text,
      'marca': marcas
              .firstWhere((e) => e['codigo'] == selectedMarca)['nome'] ??
          '',
      'modelo': modelos
              .firstWhere((e) => e['codigo'] == selectedModelo)['nome'] ??
          '',
      'ano': anos
              .firstWhere((e) => e['codigo'] == selectedAno)['nome'] ??
          '',
    };

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('carro_cadastrado', true);
    await prefs.setString('modelo_carro', carInfo['modelo']!);
    await prefs.setString('imagem_carro', '${carInfo['modelo']!.replaceAll(" ", "")}.png');

    debugPrint('Carro salvo: $carInfo');
    context.go('/car');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Preencha todos os campos obrigatórios!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final marcasFiltradas = marcas
        .where(
            (e) => e['nome']!.toLowerCase().contains(searchMarca.toLowerCase()))
        .toList();

    final modelosFiltrados = modelos
        .where((e) =>
            e['nome']!.toLowerCase().contains(searchModelo.toLowerCase()))
        .toList();

    const inputStyle = TextStyle(color: Colors.white);
    const labelStyle = TextStyle(color: Colors.white70);
    const primaryColor = Color(0xFF0A4E58);
    const secondaryColor = Color(0xFF083E47);
    const accentColor = Color.fromARGB(255, 217, 238, 242);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cadastre seu Veículo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Campo nome fantasia
            TextField(
              controller: _nomeFantasiaController,
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Nome Fantasia (Opcional)',
                labelStyle: labelStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accentColor),
                ),
                fillColor: secondaryColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 24),

            // Dropdown marca
            DropdownButtonFormField<String>(
              value: selectedMarca,
              dropdownColor: secondaryColor,
              style: inputStyle,
              iconEnabledColor: Colors.white70,
              decoration: InputDecoration(
                labelText: 'Marca',
                labelStyle: labelStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accentColor),
                ),
                fillColor: secondaryColor,
                filled: true,
              ),
              items: marcasFiltradas
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '', style: inputStyle),
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
            const SizedBox(height: 24),


            // Dropdown modelo
            DropdownButtonFormField<String>(
              value: selectedModelo,
              dropdownColor: secondaryColor,
              style: inputStyle,
              iconEnabledColor: Colors.white70,
              decoration: InputDecoration(
                labelText: 'Modelo',
                labelStyle: labelStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accentColor),
                ),
                fillColor: secondaryColor,
                filled: true,
              ),
              items: modelosFiltrados
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '', style: inputStyle),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedModelo = value;
                  selectedAno = null;
                  anos = [];
                });
                if (selectedMarca != null && value != null) {
                  fetchAnos(selectedMarca!, value);
                }
              },
            ),
            const SizedBox(height: 24),

            // Dropdown ano
            DropdownButtonFormField<String>(
              value: selectedAno,
              dropdownColor: secondaryColor,
              style: inputStyle,
              iconEnabledColor: Colors.white70,
              decoration: InputDecoration(
                labelText: 'Ano',
                labelStyle: labelStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accentColor),
                ),
                fillColor: secondaryColor,
                filled: true,
              ),
              items: anos
                  .map((e) => DropdownMenuItem<String>(
                        value: e['codigo'],
                        child: Text(e['nome'] ?? '', style: inputStyle),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAno = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // Botão salvar
            Center(
              child: ElevatedButton(
                onPressed: _saveCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Avançar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
