import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminGamesUpload extends StatefulWidget {
  const AdminGamesUpload({Key? key}) : super(key: key);

  @override
  State<AdminGamesUpload> createState() => _AdminGamesUploadState();
}

class _AdminGamesUploadState extends State<AdminGamesUpload> {
  String gameTitle = "";
  String gameDescription = "";
  String gameAge = "";

  Future<void> uploadGame() async {
    try {
      // Upload game metadata to Firestore
      await FirebaseFirestore.instance.collection('newgames').add({
        'title': gameTitle,
        'description': gameDescription,
        'age' : gameAge,
        // Add more metadata fields as needed
      });


      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Game uploaded successfully')),
      );
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload game: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games Upload"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Game Title",
              ),
              onChanged: (value) => setState(() => gameTitle = value),
            ),
            SizedBox(height: 10.0),

            TextField(
              decoration: InputDecoration(
                labelText: "Game Description",
              ),
              maxLines: 5,
              onChanged: (value) => setState(() => gameDescription = value),
            ),
            SizedBox(height: 10.0),

            TextField(
              decoration: InputDecoration(
                labelText: "Age Cateogry",
              ),
              maxLines: 1,
              onChanged: (value) => setState(() => gameDescription = value),
            ),
            SizedBox(height: 30.0),

            ElevatedButton(
              onPressed: uploadGame,
              child: Text("Upload Game"),
            ),
          ],
        ),
      ),
    );
  }
}
