import 'package:flutter/material.dart';
import 'package:app/app.classname/header.dart';
import 'package:app/app.classname/footer.dart';
import 'package:app/app.classname/search_bar.dart';
import 'package:app/screens/list_page.dart'; // Assurez-vous d'importer la bonne page de liste
import 'package:app/app.API/API_loisir.dart'; // Import the API file
import 'package:app/screens/loisirDetail_screen.dart'; // Import the LoisirDetailScreen

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
                    child: FutureBuilder(
                      future: LoisirApi.getAllLoisirs(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Erreur : ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: Text('Aucun loisir trouvé'));
                        } else {
                          var loisirs = snapshot.data as List<dynamic>;
                          loisirs.sort((a, b) =>
                              b['note'].compareTo(a['note'])); // Trier par note
                          var topLoisirs = loisirs
                              .take(5)
                              .toList(); // Prendre les 5 meilleurs
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: topLoisirs.map((loisir) {
                              return Column(
                                children: [
                                  Image.network(loisir['image'],
                                      width: 50, height: 50),
                                  Text(loisir['titre']),
                                  Text(loisir['note'].toString()),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
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
                                  // Naviguer vers la classe ListPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListPage(),
                                    ),
                                  );
                                },
                                child: const Text('Filtre ->'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FutureBuilder(
                              future: LoisirApi.getAllLoisirs(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child:
                                          Text('Erreur : ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Center(
                                      child: Text('Aucun loisir trouvé'));
                                } else {
                                  var loisirs = snapshot.data as List<dynamic>;
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: loisirs.length,
                                    itemBuilder: (context, index) {
                                      var loisir = loisirs[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoisirDetailScreen(
                                                loisir: {
                                                  'titre': loisir['titre'],
                                                  'description':
                                                      loisir['description'],
                                                  'image': loisir['image'],
                                                  'categorie':
                                                      loisir['categorie'],
                                                  'note': loisir['note'],
                                                  'date_publication': loisir[
                                                      'date_publication'],
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              color: Colors.grey,
                                              height: 100,
                                              child: Image.network(
                                                loisir['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              loisir['titre'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              loisir['note'].toString(),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
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
