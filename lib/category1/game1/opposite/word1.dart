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
    // _loadScore();
  }

  // void _loadScore() async {
  //   DocumentSnapshot<Map<String, dynamic>> snapshot =
  //   await firestore.collection('scores').doc('user_score').get();
  //   if (snapshot.exists) {
  //     setState(() {
  //       score = snapshot.data()!['score'];
  //     });
  //   }
  // }

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
              child: Text('Total Score: $score',style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15
              ),),
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
                'Write the words inside box with their opposites:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const SizedBox(
                height: 50,
                width: 50,
                child: Row(
                  children: [
                    Text(
                      "Short, Slow, Cold, Sad",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pair.opposite = value;
                                  });
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                child: const Text('Check Answer'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer() async {
    bool allCorrect = true;
    for (var pair in wordPairs) {
      if (pair.opposite.isEmpty ||
          !_isValidOpposite(pair.word, pair.opposite)) {
        allCorrect = false;
        break;
      }
    }

    if (allCorrect) {
      setState(() {
        score = wordPairs.length;
      });
      await firestore.collection('scores').doc('user_score').set({'score': score});
      _showSnackBar('All answers are correct!');
    } else {
      _showSnackBar('Some answers are incorrect. Please try again.');
    }
  }

  bool _isValidOpposite(String word, String opposite) {
    String validOpposite = validOpposites[word]?.toLowerCase() ?? '';
    String enteredOpposite = opposite.toLowerCase();
    return validOpposite == enteredOpposite;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class WordPair {
  final String word;
  String opposite;

  WordPair(this.word, this.opposite);
}