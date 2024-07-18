import 'package:app/app.API/API_loisir.dart';
import 'package:app/components/create_loisir_form.dart';
import 'package:app/screens/home_page.dart'; // Assurez-vous d'importer la HomePage
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  int currentPageIndex = 0;

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Ajoutez la navigation vers la page de loisirs si nécessaire
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              _navigateToPage(index);
            });
          },
          indicatorColor: const Color(0xFF806491),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: Color(0xFF806491)),
              icon: Icon(Icons.home_outlined, color: Color(0xFF806491)),
              label: 'Accueil',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.book, color: Colors.white),
              icon: Icon(Icons.book_outlined, color: Colors.white),
              label: 'Loisirs',
            ),
          ],
        ),
        Positioned(
          top: 5,
          child: FloatingActionButton(
            onPressed: () {
              // appel de la page de création de loisir
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateLoisirForm()),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: const Color(0xFF806491),
          ),
        ),
      ],
    );
  }
}
