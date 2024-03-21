import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/fillblanks/AnimalLevels/fill15.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird15.dart';
import 'package:game/category1/home1.dart';

class Bird14 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  const Bird14({Key? key, required this.username, required this.email, required this.age}) : super(key: key);
  @override
  State<Bird14> createState() => _Bird14State();
}

class _Bird14State extends State<Bird14> {
  TextEditingController _controller = TextEditingController();
  String _answer = '';
  bool _answeredCorrectly = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Level 14"),
        backgroundColor: Colors.lightBlue.shade100,
        actions: [
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
              "assets/Birds/ostrich.png",
              height: 200,
              width: 200,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "O",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Container(
                  width: 30,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _answer = value.toUpperCase();
                        _controller.value = TextEditingValue(
                          text: _answer,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: _answer.length),
                          ),
                        );
                      });
                    },
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  "T",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10,),
                Text(
                  "R",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Text(
                  "I",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10,),
                Text(
                  "C",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Text(
                  "H",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            _answeredCorrectly
                ? Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> Bird15(
                          username: widget.username, email: widget.email, age: widget.age
                      ),
                      ),
                    );
                  },
                  child: Text('Next Level'),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                if (!_answeredCorrectly && _answer == 'S') {
                  setState(() {
                    _answeredCorrectly = true;
                    if (score == 13){
                      score = 14; // Score becomes 1 on correct answer
                      _updateScoreInFirebase();
                    }
                  });
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Correct!'),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                } else if (!_answeredCorrectly) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incorrect! Try again.'),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home1(
                    username: widget.username, email: widget.email, age: widget.age
                )));
              },
              child: Text('Go Back to Home'),
            ),
          ],
        ),
      ),
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
    if (score == 14) {
      await Firebase.initializeApp();
      final DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(widget.username)
          .doc('fillblanks');

      // Create a new document or update the existing one
      await userDocRef.set({
        'bird': {'score': score}, // Nested data for animal category and score
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