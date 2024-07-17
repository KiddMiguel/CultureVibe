// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class LoisirDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> loisir;

//   LoisirDetailScreen({required this.loisir});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loisir['titre'] ?? 'Titre non disponible'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       loisir['image'] ?? 'https://via.placeholder.com/150',
//                       height: 200,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   loisir['titre'] ?? 'Titre non disponible',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   loisir['description'] ?? 'Description non disponible',
//                   style: TextStyle(fontSize: 16, color: Colors.black87),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Catégorie: ${loisir['categorie'] ?? 'Non disponible'}',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.grey),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Notation: ${loisir['note']?.toString() ?? 'Non noté'}',
//                   style: TextStyle(fontSize: 16, color: Colors.amber),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Date: ${loisir['date'] ?? 'Date non disponible'}',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 SizedBox(height: 16),
//                 Center(
//                   child: RatingBar.builder(
//                     initialRating: loisir['note']?.toDouble() ?? 0.0,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                       // Mettez à jour la note dans votre backend ici
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
