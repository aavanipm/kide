import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';
import 'package:game/category1/game1/speak/guessandspeak18.dart';
import 'package:game/category1/game1/speak/guesspeaklast.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeak20 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const GuessandSpeak20(
      {Key? key,
        required this.username,
        required this.email,
        required this.age,
        required this.subscribedCategory,
      })
      : super(key: key);

  @override
  _GuessandSpeak20State createState() => _GuessandSpeak20State();
}

class _GuessandSpeak20State extends State<GuessandSpeak20> {
  late stt.SpeechToText _speech;
  String spokenWord = '';
  int score = 0;

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
        title: const Text('Level 20'),
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

      body: Column( // Wrap with Stack instead of Column
        children: [
          SizedBox(height: 30,),
          Text("Press the mic button...", style: TextStyle(fontSize: 20),),
          Text("Read this", style: TextStyle(fontSize: 25),),
          SizedBox(height: 150,),
          Center(
            child: Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
          ),
          SizedBox(height: 20,),
          IconButton(
            onPressed: () => _startListening(),
            icon: Icon(Icons.mic, size: 30,),
          ),
        ],
      ),
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
  void _checkAnswer(String spokenPhrase) {
    String correctPhrase = widget.username.toLowerCase(); // Concatenate "My name is" with the username
    spokenPhrase = spokenPhrase.toLowerCase().trim();

    if (spokenPhrase.startsWith(correctPhrase)) { // Check if the spoken phrase starts with the correct phrase
      setState(() {
        if (score == 19) {
          score = 20;
          _updateScoreInFirebase();
        }
      });
      _showSnackbar('Correct answer!', true);
      Future.delayed(Duration(seconds: 3), () {
        if (widget.subscribedCategory == 'premium') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Guessandspeaklast(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              ),
            ),
          );
        } else {
          _showSubscribeMessage(); // Shows subscribe message if conditions not met
        }
      });
    } else {
      _showSnackbar('Incorrect answer!', false);
    }
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


  void _showSnackbar(String message, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 800),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
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
          _checkAnswer(result.recognizedWords);
        }
      },
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 20) {
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