import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/opposite/opposite10.dart';
import 'package:game/category1/game1/opposite/oppositelevels.dart';

class Opposite9 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Opposite9({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _Opposite9State createState() => _Opposite9State();
}

class _Opposite9State extends State<Opposite9> {
  final List<WordPair> wordPairs = [
    WordPair('NO', ''),
  ];

  final Map<String, String> validOpposites = {
    'NO': 'YES',
  };

  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  bool isLevelCompleted() {
    // Check if all word pairs are matched
    return wordPairs.every((pair) => pair.isMatched);
  }

  void goToNextLevel() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Completed Level 9! Moving to the next level...',
          style: TextStyle(fontSize: 16,),
        ),
        backgroundColor: Colors.brown,
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );

    // Delay navigation for a short duration to show the message
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Opposite10(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEVEL 9'),
        backgroundColor: Colors.brown.shade200,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context)=>Oppositelevels(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            ))
            );
          }, icon: Icon(Icons.home)),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Match the word inside box with their opposite',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildDraggableWord('GOOD'),
                  SizedBox(width: 30),
                  _buildDraggableWord('COLD'),
                  SizedBox(width: 30),
                  _buildDraggableWord('WIN'),
                  SizedBox(width: 30),
                  _buildDraggableWord('YES'),
                ],
              ),
              SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: wordPairs
                        .map(
                          (pair) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                pair.word.toUpperCase(),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return pair.isMatched
                                      ? Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      pair.opposite,
                                      style: TextStyle(fontSize: 20, color: Colors.grey),
                                    ),
                                  )
                                      : Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      pair.opposite.isEmpty ? 'Drop here' : pair.opposite,
                                      style: TextStyle(fontSize: 20, color: Colors.blue),
                                    ),

                                  );
                                },
                                onWillAccept: (data) => true,
                                onAccept: (data) {
                                  if (data == validOpposites[pair.word]) {
                                    setState(() {
                                      pair.opposite = data!;
                                      pair.isMatched = true; // Set the matched flag to true
                                      if (score == 8) {
                                        score = 9; // Score becomes 1 on correct answer
                                        _updateScoreInFirebase();
                                      }
                                      if (isLevelCompleted()) {
                                        if (widget.subscribedCategory == 'basic' || widget.subscribedCategory == 'premium' || widget.subscribedCategory == 'standard') {
                                          goToNextLevel();
                                        } else {
                                          _showSubscribeMessage();
                                        }
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),

                ),
              ),
              SizedBox(height: 70,),
              // Image.asset("assets/opposite/lightdark.png", height: 300, width: 300,),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildDraggableWord(String word) {
    return Draggable<String>(
      data: word,
      child: _buildWordBox(word),
      feedback: _buildWordBox(word),
      childWhenDragging: Container(),
    );
  }

  Widget _buildWordBox(String word) {
    return Container(
      height: 60,
      width: 65,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          word,
          style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 9) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'opposite': {'score': score},
          },
        }, SetOptions(merge: true));
      }
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve score for opposite game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('opposite')) {
            score = gameScores['opposite']['score'] ?? 0; // Default score to 0 if not found
          }
        }
      }
    }
  }
}

class WordPair {
  final String word;
  String opposite;
  bool isMatched; // Flag to indicate if the word is matched

  WordPair(this.word, this.opposite) : isMatched = false;
}
