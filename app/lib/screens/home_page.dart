import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/app.classname/search_bar.dart';
import 'package:app/components/create_loisir_form.dart';
import 'package:app/screens/list_page.dart'; // Import the SearchBar widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

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
                    color: Colors.grey[300], // Couleur de fond de rect1
                    height: MediaQuery.of(context).size.height /
                        4, // Hauteur de 1/4 de l'espace disponible
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Top 5 note :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset('images/avatar.webp',
                                    width: 50, height: 50),
                                const Text('Avatar'),
                                const Text('4.5'),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('images/goldenye.webp',
                                    width: 50, height: 50),
                                const Text('Golden Eye'),
                                const Text('4.3'),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('images/matrixx.webp',
                                    width: 50, height: 50),
                                const Text('Matrix'),
                                const Text('4.7'),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('images/meninblack.webp',
                                    width: 50, height: 50),
                                const Text('Men in Black'),
                                const Text('4.4'),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('images/titanic.webp',
                                    width: 50, height: 50),
                                const Text('Titanic'),
                                const Text('4.6'),
                              ],
                            ),
                          ],
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Naviguer vers la classe CreateLoisirForm
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HeroListPage(),
                                    ),
                                  );
                                },
                                child: const Text('filtre ->'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              padding: const EdgeInsets.all(8.0),
                              children: List.generate(4, (index) {
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      height: 100,
                                      child: Image.asset(
                                        'images/avatar.webp', // Replace with your image paths
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Image ${index + 1}', // Replace with the actual name
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '4.${index + 1}', // Replace with the actual rating
                                    ),
                                  ],
                                );
                              }),
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
          padding: EdgeInsets.all(8.0),
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
