import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/BirdLevel.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird9.dart';

class Bird8 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Bird8({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<Bird8> createState() => _Bird8State();
}

class _Bird8State extends State<Bird8> {
  String _selectedOption = '';
  bool _answeredCorrectly = false;
  int score = 0;
  String _word = "M _ N A"; // Initial word with underscore

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
                  builder: (context) => BirdLevel(
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
                    "assets/Birds/myna.png",
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
                          _selectOption('Y');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'Y' ? Colors.black : Colors.grey),
                          backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.tealAccent[100], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('Y'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('P');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'P' ? Colors.black : Colors.grey),
                          backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.tealAccent[100], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('P'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('R');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'R' ? Colors.black : Colors.grey),
                          backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.tealAccent[100], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('R'),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  _answeredCorrectly ? ElevatedButton(
                    onPressed: () {
                      if (widget.subscribedCategory == 'basic' || widget.subscribedCategory == 'premium' || widget.subscribedCategory == 'standard') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context)=> Bird9(
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
          ),
        ],
      ),
    );
  }

  void _selectOption(String option) {
    setState(() {
      if (_answeredCorrectly) return; // If already answered correctly, do nothing
      _selectedOption = option;
      _word = "M $_selectedOption N A"; // Update the word with selected option
      if (_selectedOption == 'Y') {
        _answeredCorrectly = true;
        if (score == 7) {
          score = 8; // Score becomes 1 on correct answer
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
            'fillblanksbird': {'score': score},
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
          if (gameScores.containsKey('fillblanksbird')) {
            score = gameScores['fillblanksbird']['score'] ??
                0; // Default score to 0 if not found
          }
        }
      }
    }
  }
}