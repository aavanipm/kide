// game code
// PerfectTenseGame.dart

import 'package:flutter/material.dart';
import 'package:game/category1/game1/past%20tense/levels.dart';

class PerfectTenseGame extends StatefulWidget {
  final Function(bool) onGameCompleted;

  PerfectTenseGame({required this.onGameCompleted});

  @override
  _PerfectTenseGameState createState() => _PerfectTenseGameState();
}

class _PerfectTenseGameState extends State<PerfectTenseGame> {
  List<String> words = ['Eat', 'Do', 'Go'];
  List<String> opposites = ['Eaten', 'Done', 'Gone'];
  Map<String, String?> droppedWords = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfect Tense Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Simply drag and drop the words with their matching tenses",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: words
                  .map(
                    (word) => Draggable<String>(
                  data: word,
                  child: _buildWordContainer(word),
                  feedback: _buildWordContainer(word, isDragging: true),
                  childWhenDragging: _buildWordContainer(word),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: opposites
                  .asMap()
                  .entries
                  .map(
                    (entry) => DragTarget<String>(
                  builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                    String opposite = opposites[entry.key];
                    int index = entry.key;
                    String word = words[index];
                    bool isCorrect = droppedWords[word] == opposite;
                    return Container(
                      width: 100,
                      height: 100,
                      color: isCorrect ? Colors.greenAccent.shade100 : Colors.redAccent.shade100,
                      alignment: Alignment.center,
                      child: Text(
                        isCorrect ? '✔️' : opposite,
                        style: TextStyle(color: isCorrect ? Colors.green : Colors.black),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    String word = data!;
                    int wordIndex = words.indexOf(word);
                    String expectedOpposite = opposites[wordIndex];
                    return expectedOpposite == opposites[entry.key];
                  },
                  onAccept: (data) {
                    String word = data!;
                    int wordIndex = words.indexOf(word);
                    String expectedOpposite = opposites[wordIndex];
                    setState(() {
                      droppedWords[word] = expectedOpposite;
                      if (droppedWords.length == words.length) {
                        bool allCorrect = droppedWords.entries.every(
                              (entry) => entry.value == opposites[words.indexOf(entry.key)],
                        );
                        if (allCorrect) {
                          _showLevelCompletedDialog();
                          widget.onGameCompleted(true); // Notify the parent widget
                        }
                      }
                    });
                  },
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordContainer(String word, {bool isDragging = false}) {
    return Container(
      width: 100,
      height: 100,
      color: isDragging ? Colors.grey : Colors.lightBlue,
      alignment: Alignment.center,
      child: Text(
        word,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  void _showLevelCompletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level Completed'),
          content: Text('Congratulations! You have completed the level.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LevelSelection1()));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}