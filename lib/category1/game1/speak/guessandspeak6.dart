import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/speak/guessandspeak7.dart';
import 'package:game/category1/home1.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeak6 extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const GuessandSpeak6(
      {Key? key,
        required this.username,
        required this.email,
        required this.age})
      : super(key: key);

  @override
  _GuessandSpeak6State createState() => _GuessandSpeak6State();
}

class _GuessandSpeak6State extends State<GuessandSpeak6> {
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
        title: Row(
          children: [
            Text("Level 6"),
            SizedBox(width: 120,),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home1(
                    username: widget.username, email: widget.email, age: widget.age)));
              },
              icon: Icon(Icons.home),
            ),
            Text("Score: $score"),
          ],
        ),
        backgroundColor: Colors.blue.shade100,
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

  void _checkAnswer(String guessedWord) {
    String correctWord = widget.username.toLowerCase(); // Assuming the username is the correct word to guess

    guessedWord = guessedWord.toLowerCase().trim();

    if (guessedWord == correctWord || _isSimilar(guessedWord, correctWord)) {
      setState(() {
        if (score == 5) {
          score = 6;
          _updateScoreInFirebase();
        }
      });
      _showSnackbar('Correct answer!', true);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GuessandSpeak7(
              username: widget.username, email: widget.email, age: widget.age
          )),
        );
      });
    } else {
      _showSnackbar('Incorrect answer!', false);
    }
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
    return a.length == b.length || a.contains(b) || b.contains(a);
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
    if (score == 6) {
      await Firebase.initializeApp();
      final DocumentReference documentReference =
      FirebaseFirestore.instance.collection(widget.username).doc('guessandspeak');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection(widget.username).doc('guessandspeak');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
  }
}

