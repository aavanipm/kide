import 'package:flutter/material.dart';

class SentenceTypingGame extends StatefulWidget {
  const SentenceTypingGame({Key? key}) : super(key: key);

  @override
  _SentenceTypingGameState createState() => _SentenceTypingGameState();
}

class _SentenceTypingGameState extends State<SentenceTypingGame> {
  List<String> words = ['we', 'them', 'they', 'is', 'sitting', 'talking', 'are'];
  String correctSentence = "they are talking";
  String feedbackMessage = '';
  int score = 0;
  List<String> droppedWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Typing Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/two_girls_talking.png'),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...words.map((word) {
                  if (!droppedWords.contains(word)) {
                    return Draggable<String>(
                      data: word,
                      child: _buildWordBox(word),
                      feedback: _buildWordBox(word, isFeedback: true),
                      childWhenDragging: Container(),
                    );
                  } else {
                    return Container();
                  }
                }),
                ...droppedWords.map((word) => _buildWordBox(word, isFeedback: true)),
              ],
            ),
            const SizedBox(height: 20),
            DragTarget<String>(
              builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                return Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  color: Colors.grey[300],
                  child: Text('Drop words here to form the sentence'),
                );
              },
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                _checkSentence(data);
              },
            ),
            const SizedBox(height: 20),
            Text(
              feedbackMessage,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordBox(String word, {bool isFeedback = false}) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isFeedback ? Colors.transparent : Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        word,
        style: TextStyle(color: isFeedback ? Colors.black : Colors.white),
      ),
    );
  }

  void _checkSentence(String? word) {
    if (word != null) {
      feedbackMessage = '';
      setState(() {
        droppedWords.add(word);
        if (droppedWords.length == correctSentence.split(' ').length) {
          if (correctSentence == droppedWords.join(' ')) {
            score++;
            feedbackMessage = 'Correct! Proceed to the next level.';
          } else {
            feedbackMessage = 'Incorrect. Try again.';
            droppedWords.clear();
          }
        }
      });
    }
  }
}