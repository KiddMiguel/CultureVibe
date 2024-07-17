import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/app.classname/search_bar.dart'; // Import the SearchBar widget

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
                  // `rect1` occupe 1/3 de l'espace vertical
                  Container(
                    color: Colors.grey[300], // Couleur de fond de rect1
                    height: MediaQuery.of(context).size.height /
                        3, // Hauteur de 1/3 de l'espace disponible
                    child: Center(
                      child: Text(
                        'rect1',
                      ),
                    ),
                  ),

                  // `rect2` occupe 2/3 de l'espace vertical
                  Expanded(
                    child: Container(
                      color: Colors.grey[200], // Couleur de fond de rect2
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'rect2',
                            ),
                            // Ajoutez d'autres widgets ici si nécessaire
                          ],
                        ),
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
