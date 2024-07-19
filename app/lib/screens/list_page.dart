import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/screens/loisirDetail_screen.dart'; // Assurez-vous d'importer le fichier de détail
import 'package:app/app.API/API_loisir.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> _loisirs = [];
  List<Map<String, dynamic>> _allLoisirs = [];
  List<String> _categories = [];
  bool _isLoading = true;
  String _sortCriteria = 'titre'; // Initial sort criteria
  String? _selectedCategory = 'Toutes les catégories';

  @override
  void initState() {
    super.initState();
    _fetchLoisirs();
    _fetchCategories();
  }

  Future<void> _fetchLoisirs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var loisirs = await LoisirApi.getAllLoisirs();
      setState(() {
        _allLoisirs = loisirs
            .map<Map<String, dynamic>>((loisir) => {
                  'id': loisir['id'].toString(),
                  'image': loisir['image'],
                  'titre': loisir['titre'],
                  'description': loisir['description'],
                  'categorie': loisir['category_nom'],
                  'note': loisir['note'],
                  'moyen_note': loisir['moyen_note'],
                  'date_publication': DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(loisir['date_publication']))
                })
            .toList();
        _sortLoisirs();
      });
    } catch (e) {
      print('Erreur lors de la récupération des loisirs: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchCategories() async {
    try {
      var categories = await LoisirApi.getAllCategories();
      setState(() {
        _categories = ['Toutes les catégories'];
        _categories.addAll(
            categories.map<String>((cat) => cat['nom'].toString()).toList());
      });
    } catch (e) {
      print('Erreur lors de la récupération des catégories: $e');
    }
  }

  void _sortLoisirs() {
    setState(() {
      _loisirs = List.from(_allLoisirs);

      if (_sortCriteria == 'titre') {
        _loisirs.sort((a, b) => a['titre'].compareTo(b['titre']));
      } else if (_sortCriteria == 'date') {
        _loisirs.sort(
            (a, b) => b['date_publication'].compareTo(a['date_publication']));
      }

      if (_selectedCategory != null &&
          _selectedCategory!.isNotEmpty &&
          _selectedCategory != 'Toutes les catégories') {
        _loisirs = _loisirs
            .where((loisir) => loisir['categorie'] == _selectedCategory)
            .toList();
      }
    });
  }

  void _sortLoisirsByTitle() {
    setState(() {
      _sortCriteria = 'titre';
      _sortLoisirs();
    });
  }

  void _sortLoisirsByDate() {
    setState(() {
      _sortCriteria = 'date';
      _sortLoisirs();
    });
  }

  void _filterByCategory(String? category) {
    setState(() {
      _selectedCategory = category;
      _sortLoisirs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: HeaderWidget(
          title: 'Culture Vibe',
          imagePath: 'images/logo.png',
        ),
        backgroundColor: const Color(0xFF2F70AF),
      ),
      bottomNavigationBar: FooterWidget(
          currentPage: 'Loisirs'), // Passer le nom de la page actuelle
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _sortLoisirsByTitle,
                      child: const Text('a-z'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _sortLoisirsByDate,
                      child: const Text('Date'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      hint: const Text('Catégories'),
                      items: _categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: _filterByCategory,
                      underline: Container(
                        height: 2,
                        color: const Color(0xFF2F70AF),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _loisirs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final loisir = _loisirs[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoisirDetailScreen(
                                        loisir: loisir,
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: loisir['id'],
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        loisir['image'],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          loisir['titre'],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Date: ${loisir['date_publication']}',
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Catégorie: ${loisir['categorie']}',
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${loisir['moyen_note']}/5',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.comment,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${loisir['note']} avis',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
