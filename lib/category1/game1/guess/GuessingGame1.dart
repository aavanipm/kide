import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/game1/guess/GuessingGame2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/home1.dart';

class GuessingGame1 extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  GuessingGame1({Key? key, required this.username, required this.email, required this.age}) : super(key: key);
  @override
  State<GuessingGame1> createState() => _GuessingGame1State();
}

class _GuessingGame1State extends State<GuessingGame1> {
  final Animal animal = Animal(name: "Dog", imagePath: "assets/animals/dog.png");

  TextEditingController controller = TextEditingController();
  String? userAnswer;
  int score = 0;
  bool showNextLevelButton = false; // Track whether to show Next Level button

  @override
  void initState() {
    super.initState();
    userAnswer = "";
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Row(
          children: [
            Text("Level 1"),
            SizedBox(width: 110,),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(
                    username: widget.username, email: widget.email, age: widget.age)));
              },
              icon: Icon(Icons.home), // Home button on the right side
            ),
            SizedBox(width: 5),
            Text("Score: $score"),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard when tapped outside of TextField
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                animal.imagePath,
                height: 200,
              ),
              SizedBox(height: 20), // Adjust the space between image and text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  enabled: !showNextLevelButton, // Disable text typing if showNextLevelButton is true
                  textCapitalization: TextCapitalization.characters, // Convert input to uppercase
                  onChanged: (value) {
                    setState(() {
                      userAnswer = value.toUpperCase(); // Convert to capital letters
                    });
                  },
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), // Bold and smaller text
                  decoration: InputDecoration(
                    labelText: "Type the animal name",
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call _checkAnswer() only when submit button is pressed
                  _checkAnswer();
                },
                child: Text("Submit"),
              ),
              SizedBox(height: 10,),
              if (showNextLevelButton) // Display Next Level button if showNextLevelButton is true
                ElevatedButton(
                  onPressed: () {
                    _goToNextLevel();
                  },
                  child: Text("Next Level"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer() {
    String trimmedAnswer = userAnswer!.trim().toUpperCase(); // Trim the user's answer
    if (trimmedAnswer == animal.name.toUpperCase()) { // Check uppercase
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Correct!'),
        duration: Duration(milliseconds: 700),
      ));
      setState(() {
        if (score==0){
          score = 1; // Score becomes 1 on correct answer
          _updateScoreInFirebase();
        }
        controller.text = animal.name.toUpperCase(); // Display correct answer in uppercase on TextField
        showNextLevelButton = true; // Show Next Level button
      });
      FocusScope.of(context).unfocus(); // Dismiss keyboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Incorrect. Try again!'),
        duration: Duration(milliseconds: 700),
      ));
    }
  }

  void _goToNextLevel() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessingGame2(
        username: widget.username, email: widget.email, age: widget.age)));
  }

  void _updateScoreInFirebase() async {
    // Only update score if level is completed
    if (score == 1) {
      await Firebase.initializeApp();
      final DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(widget.username)
          .doc('guessing');

      // Create a new document or update the existing one
      await userDocRef.set({
        'animal': {'score': score}, // Nested data for animal category and score
      }, SetOptions(merge: true)); // Merge to avoid overwriting other data
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('guessing');

    final DocumentSnapshot snapshot = await userDocRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('animal')) {
        setState(() {
          score = data['animal']['score'];
        });
      }
    }
  }
}

class Animal {
  final String name;
  final String imagePath;

  Animal({
    required this.name,
    required this.imagePath,
  });
}
