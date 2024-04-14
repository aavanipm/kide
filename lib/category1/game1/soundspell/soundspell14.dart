import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/soundspell/SoundSpellLevel.dart';
import 'package:game/category1/game1/soundspell/soundspell15.dart';

class SoundSpell14 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SoundSpell14({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _SoundSpell14State createState() => _SoundSpell14State();
}

class _SoundSpell14State extends State<SoundSpell14> {
  final FlutterTts flutterTts = FlutterTts();
  List<Flashcard> flashcards = [
    Flashcard(
      word: "The tree has leaves",
      image: "assets/spell/treeleaf.png",
    ),
  ];

  int score = 0;
  bool answeredCorrectly = false;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 14'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>SoundSpellLevel(
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
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFlashcard(flashcards[index]);
        },
      ),
    );
  }


  Widget _correct(Flashcard flashcard) {
    return Column(
      children: [
        Text("Yes, That was correct!",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20,),
        Image.asset(flashcard.image, height: 150, width: 150,),
        SizedBox(height: 20,),

        ElevatedButton(
          onPressed: () {
            if (widget.subscribedCategory == 'premium' || widget.subscribedCategory == 'standard') {
              Navigator.pushReplacement(
                context, MaterialPageRoute(
                builder: (context) => SoundSpell15(
                  username: widget.username,
                  email: widget.email,
                  age: widget.age,
                  subscribedCategory: widget.subscribedCategory,
                ),
              ),
              );
            } else {
              _showSubscribeMessage();
            }
          },
          child: Text('Next Level'),
        ),
      ],
    );
  }

  Widget _buildFlashcard(Flashcard flashcard) {
    TextEditingController _textEditingController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard when the user taps outside the text field
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text("Press the 'Click here to hear Button' and", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold
            )),
            Text("Write what you heard", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold
            )),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await _speakWord(flashcard.word, speed: 0.3); // Example usage with speed set to 0.5
              },
              child: Text('Click here to Hear...'),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textEditingController,
                enabled: !answeredCorrectly, // Disable the text field if the word has been correctly answered
                decoration: InputDecoration(
                  hintText: 'Type the word you heard',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            if (!answeredCorrectly) // Render the submit button only if the answer is not correct
              ElevatedButton(
                onPressed: () {
                  String typedWord = _textEditingController.text.trim().toLowerCase();
                  String correctWord = flashcard.word.toLowerCase();
                  if (typedWord == correctWord) {
                    setState(() {
                      if(score == 13) {
                        score++;
                        _updateScoreInFirebase();
                      }
                      answeredCorrectly = true;
                      FocusScope.of(context).unfocus(); // Dismiss the keyboard when the user answers correctly
                    });
                  }
                  else {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Incorrect"),
                          duration: Duration(milliseconds: 600),
                        ),
                      );
                    });
                  }
                },
                child: Text('Submit'),
              ),
            SizedBox(height: 30),
            if (answeredCorrectly)
              _correct(flashcard),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _speakWord(String word, {double speed = 0.3}) async {
    await flutterTts.setSpeechRate(speed); // Set the speech rate
    await flutterTts.speak(word);
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

  void _updateScoreInFirebase() async {
    if (score == 14) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'spell': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for matching game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('spell')) {
            score = gameScores['spell']['score'] ?? 0; // Default score to 0 if not found
          }
        }
      }
    }
  }
}

class Flashcard {
  final String word;
  final String image;

  Flashcard({
    required this.word,
    required this.image,
  });
}
