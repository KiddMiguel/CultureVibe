import 'package:flutter/material.dart';
import 'package:app/app.API/API_loisir.dart';

class LoisirDetailScreen extends StatelessWidget {
  final int loisirId;

  LoisirDetailScreen({required this.loisirId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du loisir'),
      ),
      body: FutureBuilder(
        future: LoisirApi.getLoisirById(loisirId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Loisir non trouvé'));
          } else {
            var loisir = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    loisir['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    loisir['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  // Ajoutez d'autres détails si nécessaire
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
