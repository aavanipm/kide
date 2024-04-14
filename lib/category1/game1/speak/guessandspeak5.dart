import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';
import 'package:game/category1/game1/speak/guessandspeak6.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeak5 extends StatefulWidget {

  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const GuessandSpeak5({Key? key, required this.username, required this.email,
    required this.age, required this.subscribedCategory}) : super(key: key);
  @override
  _GuessandSpeak5State createState() => _GuessandSpeak5State();
}

class _GuessandSpeak5State extends State<GuessandSpeak5> {
  final List<AnimalItem> animals = [
    AnimalItem(name: 'mango', imagePath: 'assets/Fruits/mango.png'),
  ];

  int score = 0;
  late stt.SpeechToText _speech;
  String spokenWord = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _speech.initialize(onStatus: _statusListener);
    _getStoredScore();
  }

  void _statusListener(String status) {
    print("Speech recognition status: $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 5'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>GuessSpeakLevel(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              ))
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              _showTotalPoints(score);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Press the mic button...and say", style: TextStyle(fontSize: 20),),
          Text("What is this?", style: TextStyle(fontSize: 25),),
          SizedBox(height: 150,),
          Center(
            child: _buildAnimalCard(animals[0]), // Assuming you want the first animal in the list
          ),
          IconButton(
            onPressed: () => _startListening(),
            icon: Icon(Icons.mic, size: 30,),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalCard(AnimalItem animal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(animal.imagePath, height: 200, width: 170),
      ],
    );
  }

  void _checkAnswer(String guessedAnimal) {
    String correctAnimalName = animals[0].name.toLowerCase();
    String spokenWordLower = guessedAnimal.toLowerCase();

    // Remove any leading or trailing whitespace
    guessedAnimal = guessedAnimal.trim();
    spokenWordLower = spokenWordLower.trim();

    if (spokenWordLower == correctAnimalName || _isSimilar(spokenWordLower, correctAnimalName)) {
      setState(() {
        if (score==4){
          score = 5;
          _updateScoreInFirebase();
        }
      });
      _showSnackbar('Correct answer!', true);

      // Automatically navigate to level 2
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GuessandSpeak6(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
      });
    } else {
      _showSnackbar('Incorrect answer!', false);
    }
  }

  void _showTotalPoints(int points) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Points'),
          content: Text("Your total points: $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(String message, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 800), // Adjust the duration as needed
        backgroundColor: isCorrect ? Colors.green : Colors.red, // Change color based on correctness
      ),
    );
  }

  bool _isSimilar(String a, String b) {
    return a.contains(b) || b.contains(a);
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          print('Speech recognition result: ${result.recognizedWords}');
          setState(() {
            spokenWord = result.recognizedWords;
          });
          _checkAnswer(result.recognizedWords); // Move this line to _checkAnswer method
        }
      },
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 5) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'speaking': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for speaking game
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
          if (gameScores.containsKey('speaking')) {
            score = gameScores['speaking']['score'];
          }
        }
      }
    }
  }
}

class AnimalItem {
  final String name;
  final String imagePath;

  AnimalItem({required this.name, required this.imagePath});
}


