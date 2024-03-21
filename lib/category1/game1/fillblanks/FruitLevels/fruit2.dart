import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit3.dart';
import 'package:game/category1/home1.dart';

class Fruit2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  const Fruit2({Key? key, required this.username, required this.email, required this.age}) : super(key: key);

  @override
  State<Fruit2> createState() => _Fruit2State();
}

class _Fruit2State extends State<Fruit2> {
  TextEditingController _controller = TextEditingController();
  String _answer = '';
  bool _answeredCorrectly = false;
  int score = 0; // Initial score for level 2

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
        title: Text("Level 2"),
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
              "assets/Fruits/apple.png", // Change the image path for level 2
              height: 200,
              width: 200,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Text(
                  "P",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Text(
                  "P",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 10),
                Container(
                  width: 30,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _answer = value.toUpperCase(); // Convert to uppercase
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
                SizedBox(width: 10),
                Text(
                  "E",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            _answeredCorrectly
                ? Column(
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Fruit3(
                          username: widget.username, email: widget.email, age: widget.age,)));
                    // Proceed to next level logic
                  },
                  child: Text('Next Level'),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                if (!_answeredCorrectly && _answer == 'L') {
                  setState(() {
                    _answeredCorrectly = true;
                    if (score == 1){
                      score = 2; // Score becomes 1 on correct answer
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
            SizedBox(height: 10,),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(
                    username: widget.username, email: widget.email, age: widget.age)
                  ));
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
    if (score == 2) {
      await Firebase.initializeApp();
      final DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(widget.username)
          .doc('fillblanks');

      // Create a new document or update the existing one
      await userDocRef.set({
        'fruit': {'score': score}, // Nested data for animal category and score
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
      if (data.containsKey('fruit')) {
        setState(() {
          score = data['fruit']['score'];
        });
      }
    }
  }
}