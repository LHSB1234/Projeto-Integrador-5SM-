import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:adc/src/ui/_core/widgets/my_appbar.dart'; // Importe sua AppBar customizada

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
      context.go('/car'); // Altere para a rota desejada após salvar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Preencha todos os campos obrigatórios!',
          style: TextStyle(color: Colors.white),
        )),
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
    const primaryColor = Color(0xFF0A4E58); // Cor principal do tema
    const secondaryColor = Color(0xFF083E47); // Cor secundária para elementos
    const accentColor =
        Color.fromARGB(255, 217, 238, 242); // Cor de destaque para botões

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(), // Usando sua AppBar customizada
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24), // Aumenta o padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da página
            const Text(
              'Cadastre seu Veículo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Nome Fantasia
            TextField(
              controller: _nomeFantasiaController,
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Nome Fantasia (Opcional)',
                labelStyle: labelStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accentColor), // Foco na cor de destaque
                ),
                fillColor: secondaryColor, // Fundo do TextField
                filled: true,
              ),
            ),
            const SizedBox(height: 24),

            // Busca Marca
            TextField(
              onChanged: (value) => setState(() => searchMarca = value),
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Pesquisar Marca',
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
            const SizedBox(height: 16),

            // Dropdown Marca
            DropdownButtonFormField<String>(
              value: selectedMarca,
              dropdownColor: secondaryColor, // Cor de fundo do dropdown
              style: inputStyle, // Estilo do texto dos itens
              iconEnabledColor: Colors.white70, // Cor do ícone do dropdown
              decoration: InputDecoration(
                labelText: 'Marca',
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

            // Busca Modelo
            TextField(
              onChanged: (value) => setState(() => searchModelo = value),
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Pesquisar Modelo',
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
            const SizedBox(height: 16),

            // Dropdown Modelo
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
                if (value != null && selectedMarca != null) {
                  fetchAnos(selectedMarca!, value);
                }
              },
            ),
            const SizedBox(height: 24),

            // Dropdown Ano
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
            const SizedBox(height: 48), // Aumenta o espaço antes do botão

            // Botão Salvar
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveCar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18), // Aumenta o padding do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Botão mais arredondado
                  ),
                  elevation: 8, // Adiciona sombra para um efeito 3D
                ),
                icon: const Icon(Icons.save, color: primaryColor), // Ícone com a cor principal
                label: const Text(
                  'Salvar e Continuar',
                  style: TextStyle(
                    color: primaryColor, // Texto com a cor principal
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}