import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserGamesPage extends StatelessWidget {
  final String userId;

  const UserGamesPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games Played'), // Display user ID in title
        backgroundColor: Colors.deepPurple.shade100,

      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Handle errors
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            final gameData = snapshot.data!.data() as Map<String, dynamic>?;

            if (gameData == null || gameData.isEmpty) {
              return Center(
                child: Text('No games found for this user.'),
              );
            } else {
              // Extract game names and scores
              List<DataRow> gameRows = [];
              gameData['gameData'].forEach((gameName, gameData) {
                final score = gameData['score'] ?? 0;
                gameRows.add(DataRow(
                  cells: [
                    DataCell(Text(gameName)),
                    DataCell(Text(score.toString())),
                  ],
                ));
              });

              // Display all games in a table
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Game Name')),
                    DataColumn(label: Text('Score')),
                  ],
                  rows: gameRows,
                ),
              );
            }
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
