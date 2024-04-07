import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';
import 'package:game/category1/game1/speak/guessandspeak4.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeak3 extends StatefulWidget {

  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const GuessandSpeak3({Key? key, required this.username, required this.email,
    required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  _GuessandSpeak3State createState() => _GuessandSpeak3State();
}

class _GuessandSpeak3State extends State<GuessandSpeak3> {
  final List<AnimalItem> animals = [
    AnimalItem(name: 'pigeon', imagePath: 'assets/Birds/pigeon.png'),
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
        title: Row(
          children: [
            Text("Level 3"),
            SizedBox(width: 120,),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessSpeakLevel(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
            }, icon: Icon(Icons.home)),
            Text("Score: $score"),
          ],
        ),
        backgroundColor: Colors.blue.shade100,
      ),

      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Press the mic button...and say", style: TextStyle(fontSize: 20),),
          Text("Who is this?", style: TextStyle(fontSize: 25),),
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
        if (score == 2) {
          score = 3;
          _updateScoreInFirebase();
        }
      });
      _showSnackbar('Correct answer!', true);

      // Automatically navigate to level 2
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuessandSpeak4(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
      });
    } else {
      _showSnackbar('Incorrect answer!', false); // This line ensures displaying snackbar for incorrect answer
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
          _checkAnswer(result.recognizedWords); // Move this line to _checkAnswer method
        }
      },
    );
  }

  void _updateScoreInFirebase() async {
    // Only update score if level 1 is completed
    if (score==3) {
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

class AnimalItem {
  final String name;
  final String imagePath;

  AnimalItem({required this.name, required this.imagePath});
}


