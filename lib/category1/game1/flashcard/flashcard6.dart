import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlashCard6 extends StatefulWidget {
  @override
  _FlashCard6State createState() => _FlashCard6State();
}

class _FlashCard6State extends State<FlashCard6> {
  final FlutterTts flutterTts = FlutterTts();
  SwiperController swiperController = SwiperController();
  List<Flashcard> flashcards = [
    Flashcard(
      image: 'assets/animals/cat.png',
      word: 'Cat',
    ),
    Flashcard(
      image: 'assets/animals/dog.png',
      word: 'Dog',
    ),
  ];

  int score = 0;
  bool allowSwiping = false;
  bool answeredCorrectly = false;
  int currentCardIndex = 0; // Track the index of the current flashcard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 6'),
      ),
      body: Swiper(
        controller: swiperController,
        itemCount: flashcards.length,
        loop: false,
        physics: allowSwiping
            ? ClampingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        // Disable swiper if allowSwiping is false
        itemBuilder: (BuildContext context, int index) {
          Flashcard flashcard = flashcards[index];
          return _buildFlashcard(flashcard);
        },
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  Widget _correct(Flashcard flashcard) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Yes, That was correct!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Image.asset(flashcard.image, height: 150, width: 150,),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Move to the next flashcard
                currentCardIndex++;
                allowSwiping = false; // Disable swiping on tap
                answeredCorrectly = false; // Reset answeredCorrectly flag
              });
            },
            child: Text('Next Word'),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(Flashcard flashcard) {
    TextEditingController _textEditingController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard when the user taps outside the text field
        if (allowSwiping) {
          setState(() {
            allowSwiping = false; // Disable swiping on tap
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
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
                    allowSwiping = true; // Enable swiping after correct answer
                    answeredCorrectly = true;
                    FocusScope.of(context).unfocus(); // Dismiss the keyboard when the user answers correctly
                  });
                } else {
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
      ),
    );
  }

  Future<void> _speakWord(String word) async {
    await flutterTts.speak(word);
  }
}

class Flashcard {
  final String image;
  final String word;

  Flashcard({
    required this.image,
    required this.word,
  });
}
