import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/screens/loisirDetail_screen.dart'; // Assurez-vous d'importer le fichier de détail

class HeroListPage extends StatefulWidget {
  const HeroListPage({Key? key}) : super(key: key);

  @override
  _HeroListPageState createState() => _HeroListPageState();
}

class _HeroListPageState extends State<HeroListPage> {
  List<Map<String, dynamic>> _loisirs = [
    {
      'id': '1',
      'image':
          'https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'titre': 'a',
      'description': 'Description du loisir 1',
      'categorie': 'Catégorie 1',
      'note': 4.5,
      'date_publication': '2024-07-15'
    },
    {
      'id': '2',
      'image':
          'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'titre': 'c',
      'description': 'Description du loisir 2',
      'categorie': 'Catégorie 2',
      'note': 4.5,
      'date_publication': '2024-07-14'
    },
    {
      'id': '3',
      'image':
          'https://images.pexels.com/photos/273935/pexels-photo-273935.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'titre': 'b',
      'description': 'Description du loisir 3',
      'categorie': 'Catégorie 3',
      'note': 4.5,
      'date_publication': '2024-07-13'
    },
    {
      'id': '4',
      'image':
          'https://images.pexels.com/photos/1591373/pexels-photo-1591373.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'titre': 'a',
      'description': 'Description du loisir 4',
      'categorie': 'Catégorie 4',
      'note': 4.5,
      'date_publication': '2024-07-12'
    },
    {
      'id': '5',
      'image':
          'https://images.pexels.com/photos/462024/pexels-photo-462024.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'titre': 'e',
      'description': 'Description du loisir 5',
      'categorie': 'Catégorie 5',
      'note': 4.5,
      'date_publication': '2024-07-11'
    },
    {
      'id': '6',
      'image':
          'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'titre': 'c',
      'description': 'Description du loisir 6',
      'categorie': 'Catégorie 6',
      'note': 4.5,
      'date_publication': '2024-07-10'
    },
  ];

  void _sortLoisirsByTitle() {
    setState(() {
      _loisirs.sort((a, b) => a['titre'].compareTo(b['titre']));
    });
  }

  void _sortLoisirsByDate() {
    setState(() {
      _loisirs.sort(
          (a, b) => b['date_publication'].compareTo(a['date_publication']));
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
      bottomNavigationBar: FooterWidget(),
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
                child: ListView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
