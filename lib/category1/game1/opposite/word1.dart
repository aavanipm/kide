import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OppositeWordsGame extends StatefulWidget {
  OppositeWordsGame({Key? key}) : super(key: key);

  @override
  _OppositeWordsGameState createState() => _OppositeWordsGameState();
}

class _OppositeWordsGameState extends State<OppositeWordsGame> {
  final List<WordPair> wordPairs = [
    WordPair('Happy', ''),
    WordPair('Hot', ''),
    WordPair('Fast', ''),
    WordPair('Tall', ''),
  ];

  int score = 0;

  final Map<String, String> validOpposites = {
    'Happy': 'Sad',
    'Hot': 'Cold',
    'Fast': 'Slow',
    'Tall': 'Short',
  };

  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opposite Game'),
        backgroundColor: Colors.blue,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('Total Score: $score', style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15
              ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Match the words inside box with their opposites:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildDraggableWord('Short'),
                  SizedBox(width: 10),
                  _buildDraggableWord('Slow'),
                  SizedBox(width: 10),
                  _buildDraggableWord('Cold'),
                  SizedBox(width: 10),
                  _buildDraggableWord('Sad'),
                ],
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: wordPairs
                        .map(
                          (pair) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                pair.word,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return pair.isMatched
                                      ? Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      pair.opposite,
                                      style: TextStyle(fontSize: 20, color: Colors.grey),
                                    ),
                                  )
                                      : Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      pair.opposite.isEmpty ? 'Drop here' : pair.opposite,
                                      style: TextStyle(fontSize: 20, color: Colors.blue),
                                    ),
                                  );
                                },
                                onWillAccept: (data) => true,
                                onAccept: (data) {
                                  if (data == validOpposites[pair.word]) {
                                    setState(() {
                                      pair.opposite = data!;
                                      pair.isMatched = true; // Set the matched flag to true
                                      score++; // Increase the score
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableWord(String word) {
    return Draggable<String>(
      data: word,
      child: _buildWordBox(word),
      feedback: _buildWordBox(word),
      childWhenDragging: Container(),
    );
  }

  Widget _buildWordBox(String word) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          word,
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
}

class WordPair {
  final String word;
  String opposite;
  bool isMatched; // Flag to indicate if the word is matched

  WordPair(this.word, this.opposite) : isMatched = false;
}
