import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/number9.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/numberlevel.dart';

class Number8 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Number8({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<Number8> createState() => _Number8State();
}

class _Number8State extends State<Number8> {
  String _selectedOption = '';
  bool _answeredCorrectly = false;
  int score = 0;
  String _word = "E I _ H T"; // Initial word with underscore

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Level 8"),
        backgroundColor: Colors.lightBlue.shade100,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumberLevel(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Numbers/8.png",
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
                    _selectOption('W');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'W' ? Colors.black : Colors.grey),
                    backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.yellow[200], // Adjust color based on _answeredCorrectly
                  ),
                  child: Text('W'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _answeredCorrectly ? null : () {
                    _selectOption('O');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'O' ? Colors.black : Colors.grey),
                    backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.yellow[200], // Adjust color based on _answeredCorrectly
                  ),
                  child: Text('O'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _answeredCorrectly ? null : () {
                    _selectOption('G');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'G' ? Colors.black : Colors.grey),
                    backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.yellow[200], // Adjust color based on _answeredCorrectly
                  ),
                  child: Text('G'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _answeredCorrectly ? null : () {
                    _selectOption('L');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'L' ? Colors.black : Colors.grey),
                    backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.yellow[200], // Adjust color based on _answeredCorrectly
                  ),
                  child: Text('L'),
                ),
              ],
            ),
            SizedBox(height: 20),
            _answeredCorrectly ? ElevatedButton(
              onPressed: () {
                if (widget.subscribedCategory == 'basic' || widget.subscribedCategory == 'premium' || widget.subscribedCategory == 'standard') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=> Number9(
                      username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                    ),
                    ),
                  );
                } else {
                  _showSubscribeMessage();
                }
              },
              child: Text('Next Level'),
            ) : SizedBox(), // Show or hide based on _answeredCorrectly
          ],
        ),
      ),
    );
  }

  void _selectOption(String option) {
    setState(() {
      if (_answeredCorrectly) return; // If already answered correctly, do nothing
      _selectedOption = option;
      _word = "E I $_selectedOption H T"; // Update the word with selected option
      if (_selectedOption == 'G') {
        _answeredCorrectly = true;
        if (score == 7) {
          score = 8; // Score becomes 8 on correct answer
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

  void _showSubscribeMessage() {
    String message = 'Subscribe to access more levels.';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscription Required'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory)));
                // Navigate to subscription page
              },
              child: Text('Subscribe'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
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
    if (score == 8) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'fillblanksnumber': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for fillblanksnumber game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('fillblanksnumber')) {
            score = gameScores['fillblanksnumber']['score'] ?? 0; // Default score to 0 if not found
          }
        }
      }
    }
  }
}