import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/admin/adminhome.dart';

class AddNewGamePage extends StatefulWidget {
  @override
  State<AddNewGamePage> createState() => _AddNewGamePageState();
}

class _AddNewGamePageState extends State<AddNewGamePage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  bool isNewGameAdded = false;

  void handleNewGameNotification() {
    setState(() {
      isNewGameAdded = true;
    });
  }

  Future<void> _saveGame(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('games').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Game saved')));

      handleNewGameNotification();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } catch (e) {
      print('Error saving game: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Game Name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter game name',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter game description',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveGame(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
