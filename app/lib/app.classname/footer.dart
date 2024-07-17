import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
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
              selectedIcon: Icon(Icons.book,
                  color: Colors.white), // Appropriate icon for loisirs
              icon: Icon(Icons.book_outlined, color: Colors.white),
              label: 'Loisirs',
            ),
          ],
        ),
        Positioned(
          top: 5,
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: const Color(0xFF806491),
          ),
        ),
      ],
    );
  }
}
