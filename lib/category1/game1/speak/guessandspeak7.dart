import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';
import 'package:game/category1/game1/speak/guessandspeak8.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeak7 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const GuessandSpeak7(
      {Key? key,
        required this.username,
        required this.email,
        required this.age,
        required this.subscribedCategory,
      })
      : super(key: key);

  @override
  _GuessandSpeak7State createState() => _GuessandSpeak7State();
}

class _GuessandSpeak7State extends State<GuessandSpeak7> {
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
            Text("Level 7"),
            SizedBox(width: 120,),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GuessSpeakLevel(
                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: '',)));
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
            child: Text("My name is " + widget.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
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

  void _checkAnswer(String spokenPhrase) {
    String correctPhrase = "my name is " + widget.username.toLowerCase(); // Concatenate "My name is" with the username

    spokenPhrase = spokenPhrase.toLowerCase().trim();

    if (spokenPhrase.startsWith(correctPhrase)) { // Check if the spoken phrase starts with the correct phrase
      setState(() {
        if (score == 6) {
          score = 7;
          _updateScoreInFirebase();
        }
      });
      _showSnackbar('Correct answer!', true);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GuessandSpeak8(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
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
        duration: Duration(milliseconds: 800),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
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
    if (score == 7) {
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

