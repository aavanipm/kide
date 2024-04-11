import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/synonym/Synonymlevels.dart';
import 'package:game/category1/game1/synonym/synonym3.dart';

class Synonym2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Synonym2({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  _Synonym2State createState() => _Synonym2State();
}

class _Synonym2State extends State<Synonym2> {
  final Map<String, List<String>> wordSynonyms = {
    'sad': ['gloomy', 'unhappy', 'sorrow'],
  };

  final Map<String, List<String>> wordNotSimilar = {
    'sad': ['joyful', 'happy', 'glad'],
  };

  List<String> displayedOptions = [];
  String currentWord = '';
  List<String> correctSynonyms = [];
  bool showCorrectSynonyms = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
    _nextWord();
  }

  void _nextWord() {
    setState(() {
      displayedOptions.clear();
      currentWord = 'sad';
      displayedOptions.addAll(wordSynonyms[currentWord]!);
      displayedOptions.addAll(wordNotSimilar[currentWord]!);
      displayedOptions.shuffle();
      correctSynonyms = wordSynonyms[currentWord]!;
      showCorrectSynonyms = false;
    });
  }

  void _checkAnswer(String selectedWord) {
    setState(() {
      if (wordSynonyms[currentWord]!.contains(selectedWord)) {
        if (score == 3) {
          score = 6; // Set score to 3 directly
          _updateScoreInFirebase(); // Update score in Firebase
        }
        correctSynonyms.remove(selectedWord);
        displayedOptions.remove(selectedWord); // Remove the selected word from displayedOptions
        showCorrectSynonyms = true;
      }
      if (correctSynonyms.isEmpty) {
        _showAllCorrectMessage();
      } else {
        _nextWord();
      }
    });
  }

  void _showTotalPoints(int points) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Points'),
          content: Text("Score: $score"),
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

  void _showAllCorrectMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have found all the correct synonyms.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextWord();
              },
              child: Text('Ok'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>
                          Synonym3(
                              username: widget.username,
                              email: widget.email,
                              age: widget.age,
                              subscribedCategory: widget.subscribedCategory
                          )));
                }, child: Text("Next level")),
          ],
        );
      },
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 6) {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
          'gameData': {
            'synonym': {'score': score},
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
          if (gameScores.containsKey('synonym')) {
            score = gameScores['synonym']['score'] ?? 0; // Default score to 0 if not found
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 2'),
        backgroundColor: Colors.blue.shade400,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>SynonymLevels(
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
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Find the synonym for : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  currentWord,
                  style: const TextStyle(fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Options:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: displayedOptions.map((word) {
                  return ElevatedButton(
                    onPressed: () => _checkAnswer(word),
                    child: Text(
                      word,
                      style: TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}