import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/screens/loisirDetail_screen.dart'; // Assurez-vous d'importer le fichier de détail
import 'package:app/app.API/API_loisir.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> _loisirs = [];
  bool _isLoading = true;
  String _sortCriteria = 'titre'; // Initial sort criteria

  @override
  void initState() {
    super.initState();
    _fetchLoisirs();
  }

  Future<void> _fetchLoisirs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var loisirs = await LoisirApi.getAllLoisirs();
      setState(() {
        _loisirs = loisirs
            .map<Map<String, dynamic>>((loisir) => {
                  'id': loisir['id'].toString(),
                  'image': loisir['image'],
                  'titre': loisir['titre'],
                  'description': loisir['description'],
                  'categorie': loisir['categorie'],
                  'note': loisir['note'],
                  'date_publication': loisir['date_publication'],
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

  void _sortLoisirs() {
    setState(() {
      if (_sortCriteria == 'titre') {
        _loisirs.sort((a, b) => a['titre'].compareTo(b['titre']));
      } else if (_sortCriteria == 'date') {
        _loisirs.sort(
            (a, b) => b['date_publication'].compareTo(a['date_publication']));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _sortLoisirsByTitle,
                    child: const Text('a-z'),
                  ),
                  ElevatedButton(
                    onPressed: _sortLoisirsByDate,
                    child: const Text('Date'),
                  ),
                ],
              ),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
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
                                        width: 200,
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
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Date: ${loisir['date_publication']}',
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
