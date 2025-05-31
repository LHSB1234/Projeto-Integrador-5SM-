import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VehicleRegisterPage extends StatefulWidget {
  const VehicleRegisterPage({super.key});

  @override
  State<VehicleRegisterPage> createState() => _VehicleRegisterPageState();
}

class _VehicleRegisterPageState extends State<VehicleRegisterPage> {
  final List<Map<String, dynamic>> _vehicles = [];

  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateController = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _openAddVehicleForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFEFF6F7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Adicionar Veículo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                      backgroundColor: Colors.grey[300],
                      child: _selectedImage == null
                          ? const Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: "Marca"),
                    validator: (value) => value == null || value.isEmpty ? "Informe a marca" : null,
                  ),
                  TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: "Modelo do veículo 🚗"),
                    validator: (value) => value == null || value.isEmpty ? "Informe o modelo" : null,
                  ),
                  TextFormField(
                    controller: _plateController,
                    decoration: const InputDecoration(labelText: "Placa"),
                    validator: (value) => value == null || value.isEmpty ? "Informe a placa" : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A4E58),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _vehicles.add({
                            "marca": _brandController.text,
                            "modelo": _modelController.text,
                            "placa": _plateController.text,
                            "imagem": _selectedImage?.path,
                          });
                          _brandController.clear();
                          _modelController.clear();
                          _plateController.clear();
                          _selectedImage = null;
                        });
                        Navigator.of(ctx).pop();
                      }
                    },
                    child: const Text("Cadastrar"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteVehicle(int index) {
    setState(() {
      _vehicles.removeAt(index);
    });
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seus Veículos"),
        backgroundColor: const Color(0xFF0f6b79),
      ),
      backgroundColor: const Color(0xFFEFF6F7),
      body: _vehicles.isEmpty
          ? const Center(child: Text("Nenhum veículo cadastrado ainda.", style: TextStyle(fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _vehicles[index];
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: vehicle["imagem"] != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(vehicle["imagem"])),
                          )
                        : const Icon(Icons.directions_car),
                    title: Text("${vehicle["marca"]} ${vehicle["modelo"]}"),
                    subtitle: Text("Placa: ${vehicle["placa"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0A4E58),
        onPressed: _openAddVehicleForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir veículo"),
        content: const Text("Deseja realmente excluir este veículo?"),
        actions: [
          TextButton(child: const Text("Cancelar"), onPressed: () => Navigator.of(ctx).pop()),
          TextButton(
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            onPressed: () {
              _deleteVehicle(index);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
