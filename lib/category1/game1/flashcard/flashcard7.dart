import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:game/category1/game1/flashcard/flashcard6.dart';
import 'package:game/category1/game1/flashcard/flashcard8.dart';

class FlashCard7 extends StatefulWidget {
  const FlashCard7({super.key});

  @override
  _FlashCard7State createState() => _FlashCard7State();
}

class _FlashCard7State extends State<FlashCard7> {
  final FlutterTts flutterTts = FlutterTts();
  List<Flashcard> flashcards = [
    Flashcard(
      word: 'My name is',
      image: "assets/animals/cat.png",
      username: '',
    ),
  ];

  int score = 0;
  bool answeredCorrectly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 7'),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard8()));
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await _speakWord(flashcard.word);
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
          ElevatedButton(
            onPressed: () {
              String typedWord = _textEditingController.text.trim().toLowerCase();
              String correctWord = flashcard.word.toLowerCase();
              if (typedWord == correctWord) {
                setState(() {
                  score++;
                  answeredCorrectly = true;
                  FocusScope.of(context).unfocus(); // Dismiss the keyboard when the user answers correctly
                });
              }
              else {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Incorrect"),
                      duration: Duration(milliseconds: 500),
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
    );
  }

  Future<void> _speakWord(String word) async {
    await flutterTts.speak(word);
  }
}

class Flashcard {
  final String word;
  final String image;
  final String username;
 // final String email;

  Flashcard({
    required this.word,
    required this.image,
    required this.username,
  //  required this.email,
  });
}
