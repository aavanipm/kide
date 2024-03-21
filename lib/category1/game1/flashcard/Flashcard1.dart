import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:game/category1/game1/flashcard/FlashCard2.dart';

class FlashCard1 extends StatefulWidget {
  @override
  _FlashCard1State createState() => _FlashCard1State();
}

class _FlashCard1State extends State<FlashCard1> {
  final FlutterTts flutterTts = FlutterTts();
  List<Flashcard> flashcards = [
    Flashcard(
      word: 'Cat',
      image: "assets/animals/cat.png",
    ),
  ];

  int score = 0;
  bool answeredCorrectly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 1'),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard2()));
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

  Flashcard({
    required this.word,
    required this.image,
  });
}
