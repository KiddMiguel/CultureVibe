import 'package:flutter/material.dart';
import 'package:app/app.API/API_loisir.dart'; // Assurez-vous d'importer votre fichier API

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];
  List<dynamic> _allLoisirs = [];

  @override
  void initState() {
    super.initState();
    _fetchAllLoisirs();
  }

  Future<void> _fetchAllLoisirs() async {
    try {
      final List<dynamic> allLoisirs = await LoisirApi.getAllLoisirs();
      setState(() {
        _allLoisirs = allLoisirs;
      });
    } catch (e) {
      print('Erreur lors de la requête : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
    );

    return Theme(
      data: themeData,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[200],
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Action à réaliser lors de l'appui sur le bouton
                      print("Filter button pressed");
                    },
                  ),
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              _searchingWithQuery = controller.text;

              final List<String> options = _allLoisirs
                  .map((loisir) =>
                      loisir['titre']?.toString() ??
                      'Nom inconnu') // Vérification pour valeur nulle
                  .where((name) => name
                      .toLowerCase()
                      .contains(_searchingWithQuery!.toLowerCase()))
                  .toList();

              if (_searchingWithQuery != controller.text) {
                return _lastOptions;
              }

              _lastOptions =
                  List<ListTile>.generate(options.length, (int index) {
                final String item = options[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });

              return _lastOptions;
            },
          ),
        ),
      ),
    );
  }
}
