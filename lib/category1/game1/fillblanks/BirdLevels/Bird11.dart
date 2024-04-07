import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/Bird12.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/BirdLevel.dart';

class Bird11 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Bird11({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<Bird11> createState() => _Bird11State();
}

class _Bird11State extends State<Bird11> {
  String _selectedOption = '';
  bool _answeredCorrectly = false;
  int score = 0;
  String _word = "P _ G E O N"; // Initial word with underscore

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Level 11"),
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
                    "assets/Birds/pigeon.png",
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
                          _selectOption('G');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'G' ? Colors.black : Colors.grey),
                          backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.tealAccent[100], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('G'),
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
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _answeredCorrectly ? null : () {
                          _selectOption('I');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _selectedOption == 'I' ? Colors.black : Colors.grey),
                          backgroundColor: _answeredCorrectly ? Colors.grey[300] : Colors.tealAccent[100], // Adjust color based on _answeredCorrectly
                        ),
                        child: Text('I'),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  _answeredCorrectly ? ElevatedButton(
                    onPressed: () {
                      if (widget.subscribedCategory == 'premium' || widget.subscribedCategory == 'standard') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context)=> Bird12(
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
      _word = "P $_selectedOption G E O N"; // Update the word with selected option
      if (_selectedOption == 'I') {
        _answeredCorrectly = true;
        if (score == 10) {
          score = 11; // Score becomes 1 on correct answer
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
    // Only update score if level is completed
    if (score == 11) {
      await Firebase.initializeApp();
      final DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(widget.username)
          .doc('fillblanks');

      // Create a new document or update the existing one
      await userDocRef.set({
        'bird': {'score': score}, // Nested data for bird category and score
      }, SetOptions(merge: true)); // Merge to avoid overwriting other data
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('fillblanks');

    final DocumentSnapshot snapshot = await userDocRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('bird')) {
        setState(() {
          score = data['bird']['score'];
        });
      }
    }
  }
}
