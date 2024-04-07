import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:game/category1/game1/soundspell/SoundSpellLevel.dart';
import 'package:game/category1/game1/soundspell/soundspell3.dart';

class SoundSpell2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SoundSpell2({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _SoundSpell2State createState() => _SoundSpell2State();
}

class _SoundSpell2State extends State<SoundSpell2> {
  final FlutterTts flutterTts = FlutterTts();
  List<Flashcard> flashcards = [
    Flashcard(
      word: 'Dog',
      image: "assets/animals/dog.png",
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
        title: Row(
          children: [
            Text("Level 2"),
            SizedBox(width: 120,),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SoundSpellLevel(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
            }, icon: Icon(Icons.home)),
            Text("Score: $score",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade200,
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SoundSpell3(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
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
                      if(score == 1) {
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

  void _updateScoreInFirebase() async {
    // Only update score if level 1 is completed
    if (score==2) {
      await Firebase.initializeApp();
      final DocumentReference documentReference =
      FirebaseFirestore.instance.collection(widget.username).doc('soundspell');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection(widget.username).doc('soundspell');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
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
