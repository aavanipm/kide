import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/guess/GuessingGame3.dart';
import 'package:game/category1/game1/guess/levelguess.dart';

class GuessingGame2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  GuessingGame2({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);
  @override
  State<GuessingGame2> createState() => _GuessingGame2State();
}

class _GuessingGame2State extends State<GuessingGame2> {
  final Animal animal = Animal(name: "Crow", imagePath: "assets/Birds/crow.png");

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
            Text("Level 2"),
            SizedBox(width: 110,),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelGuess(
                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
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
        if (score==1){
          score = 2; // Score becomes 1 on correct answer
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GuessingGame3(
        username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
  }

  void _updateScoreInFirebase() async {
    if (score == 2) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'guessing': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for guessing game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('guessing')) {
            score = gameScores['guessing']['score'] ?? 0; // Default score to 0 if not found
          }
        }
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
