import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/fillblanks/AnimalLevels/fill4.dart';
import 'package:game/category1/game1/fillblanks/AnimalLevels/levelsfill.dart';

class Fill3 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Fill3({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<Fill3> createState() => _Fill3State();
}

class _Fill3State extends State<Fill3> {
  String _selectedOption = '';
  bool _answeredCorrectly = false;
  int score = 0;
  String _word = "F O _"; // Initial word with underscore

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Level 3"),
        backgroundColor: Colors.lightBlue.shade100,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LevelFill(
                        username: widget.username,
                        email: widget.email,
                        age: widget.age,
                        subscribedCategory: widget.subscribedCategory,
                      ),
                ),
              );
            },
            icon: Icon(Icons.home), // Home button on the right side
          ),
          IconButton(
            onPressed: () {
              _showScoreDialog();
            },
            icon: Icon(Icons.star),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Select the correct letter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/animals/fox.png",
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _word, // Display the word dynamically
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('O');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _selectedOption == 'O'
                                  ? Colors.black
                                  : Colors.grey),
                          backgroundColor: _answeredCorrectly
                              ? Colors.grey[300]
                              : Colors
                              .yellow[200], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('O'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('X');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _selectedOption == 'X'
                                  ? Colors.black
                                  : Colors.grey),
                          backgroundColor: _answeredCorrectly
                              ? Colors.grey[300]
                              : Colors
                              .yellow[200], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('X'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('B');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _selectedOption == 'B'
                                  ? Colors.black
                                  : Colors.grey),
                          backgroundColor: _answeredCorrectly
                              ? Colors.grey[300]
                              : Colors
                              .yellow[200], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('B'),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  _answeredCorrectly ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) =>
                            Fill4(
                              username: widget.username,
                              email: widget.email,
                              age: widget.age,
                              subscribedCategory: widget.subscribedCategory,
                            ),
                      ),
                      );
                    },
                    child: Text('Next Level'),
                  ) : SizedBox(), // Show or hide based on _answeredCorrectly
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectOption(String option) {
    setState(() {
      if (_answeredCorrectly)
        return; // If already answered correctly, do nothing
      _selectedOption = option;
      _word = "F O $_selectedOption"; // Update the word with selected option
      if (_selectedOption == 'X') {
        _answeredCorrectly = true;
        if (score == 2) {
          score = 3; // Score becomes 3 on correct answer
          _updateScoreInFirebase();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Correct!',
            ),
            duration: Duration(milliseconds: 700),
          ),
        );
      } else {
        _answeredCorrectly = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Incorrect! Try again.',
            ),
            duration: Duration(milliseconds: 700),
          ),
        );
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Score'),
          content: Text('Score: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 3) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'fillblanksanimal': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for fillblanksbird game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<
            String,
            dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('fillblanksanimal')) {
            score = gameScores['fillblanksanimal']['score'];
          }
        }
      }
    }
  }
}