import 'package:app/app.API/API_loisir.dart'; // Assurez-vous que ce chemin est correct
import 'package:flutter/material.dart';

class CreateLoisirForm extends StatefulWidget {
  const CreateLoisirForm({super.key});

  @override
  State<CreateLoisirForm> createState() => _CreateLoisirFormState();
}

class _CreateLoisirFormState extends State<CreateLoisirForm> {
  final _formKey = GlobalKey<FormState>();
  List<Category> categories = [];
  Category? selectedCategory;

  Future<List<Category>> getAllCategories() async {
    try {
      var response = await LoisirApi.getAllCategories();
      return response.map<Category>((json) => Category.fromJson(json)).toList();
    } catch (e) {
      return Future.error("Error: ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCategories().then((categories) {
      setState(() {
        this.categories = categories;
      });
    }).catchError((error) {
      // Handle errors if needed
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer Loisir'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              ListTile(
                title: const Text('Date de publication'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    // Mise à jour de l'état ou stockage de la date
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une URL d\'image';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<Category>(
                decoration: const InputDecoration(labelText: 'Catégorie'),
                value: selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: categories.map<DropdownMenuItem<Category>>((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.nom),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner une catégorie';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validation et traitement des données
                  }
                },
                child: const Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final int id;
  final String nom;

  Category({required this.id, required this.nom});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      nom: json['nom'],
    );
  }
}
