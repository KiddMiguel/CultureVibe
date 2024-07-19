import 'package:flutter/material.dart';
import 'package:app/app.API/API_loisir.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/app.classname/search_bar.dart';
import 'package:app/screens/list_page.dart';
import 'package:app/screens/loisirDetail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<dynamic> _topLoisirs = [];
  List<dynamic> _allLoisirs = [];

  @override
  void initState() {
    super.initState();
    _fetchTopLoisir();
    _fetchAllLoisirs();
  }

  Future<void> _fetchTopLoisir() async {
    try {
      final topLoisirs = await LoisirApi.getTopLoisir();
      setState(() {
        _topLoisirs = topLoisirs;
      });
    } catch (e) {
      print('Failed to load top loisirs: $e');
    }
  }

  Future<void> _fetchAllLoisirs() async {
    try {
      final allLoisirs = await LoisirApi.getAllLoisirs();
      setState(() {
        _allLoisirs = allLoisirs;
      });
    } catch (e) {
      print('Failed to load all loisirs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(
          title: 'Culture Vibe',
          imagePath: 'images/logo.png',
        ),
        backgroundColor: const Color(0xFF2F70AF),
      ),
      bottomNavigationBar: const FooterWidget(),
      body: <Widget>[
        /// Home page
        Column(
          children: [
            // La barre de recherche en haut
            const SearchBarWidget(),
            // Contenu de la page d'accueil
            Expanded(
              child: Column(
                children: [
                  // `rect1` occupe 1/4 de l'espace vertical
                  Container(
                    color: Colors.grey[200], // Couleur de fond de rect1
                    height: MediaQuery.of(context).size.height /
                        4, // Hauteur de 1/4 de l'espace disponible
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Découvrez les meilleurs loisirs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 4 - 40,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            viewportFraction: 0.8,
                          ),
                          items: _topLoisirs.map((loisir) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoisirDetailScreen(loisir: loisir),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 110,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                loisir['image'] ??
                                                    'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              color: Colors.black.withOpacity(
                                                  0.5), // Fond noir semi-transparent
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                loisir['titre'] ??
                                                    'Titre inconnu',
                                                style: const TextStyle(
                                                    color: Colors
                                                        .white), // Pour que le texte soit visible sur le fond noir
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.grade_rounded,
                                                    size: 15,
                                                    color: Colors.yellow),
                                                Text(
                                                  '${loisir['note'] ?? 0} avis',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      RatingBarIndicator(
                                        rating: (loisir['average_note'] ?? 0)
                                            .toDouble(),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  // `rect2` occupe 3/4 de l'espace vertical
                  Expanded(
                    child: Container(
                      color: Colors.grey[200], // Couleur de fond de rect2
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Toutes les activités',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              padding: const EdgeInsets.all(8.0),
                              children: _allLoisirs.map((loisir) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoisirDetailScreen(loisir: loisir),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 93, 83, 85),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            loisir['image'] ??
                                                'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        loisir['titre'] != null &&
                                                loisir['titre'].length > 15
                                            ? '${loisir['titre'].substring(0, 15)}...'
                                            : loisir['titre'] ??
                                                'Titre inconnu',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        loisir['description'] != null &&
                                                loisir['description'].length >
                                                    13
                                            ? '${loisir['description'].substring(0, 13)}...'
                                            : loisir['description'] ??
                                                'Aucune description',
                                      ),
                                      RatingBarIndicator(
                                        rating: ((loisir['moyen_note']) ?? 0.0)
                                            .toDouble(),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.grade_rounded,
                                              size: 15, color: Colors.yellow),
                                          Text(
                                            '${loisir['note'] ?? 0} avis',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}
