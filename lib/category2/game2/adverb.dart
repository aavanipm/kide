import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdverbQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  AdverbQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _AdverbQuestionsPageState createState() => _AdverbQuestionsPageState();
}

class _AdverbQuestionsPageState extends State<AdverbQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions

  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Which word modifies a verb, adjective, or other adverb?',
      'options': ['house', 'jump', 'quickly', 'book'],
      'correctAnswer': 'quickly',
    },
    {
      'number': '2',
      'question': 'Identify the adverb in the sentence: "She sings very loudly."',
      'options': ['sings', 'very', 'loudly', 'she'],
      'correctAnswer': 'loudly',
    },
    {
      'number': '3',
      'question': 'What adverb means "in a secretive or sneaky manner"?',
      'options': ['slowly', 'quietly', 'quickly', 'sneakily'],
      'correctAnswer': 'sneakily',
    },
    {
      'number': '4',
      'question': 'Choose the adverb in the sentence: "They walked carefully along the narrow path."',
      'options': ['walked', 'carefully', 'along', 'narrow'],
      'correctAnswer': 'carefully',
    },
    {
      'number': '5',
      'question': 'Identify the adverb in the sentence: "The sun shines brightly in the sky."',
      'options': ['sun', 'shines', 'brightly', 'sky'],
      'correctAnswer': 'brightly',
    },
    {
      'number': '6',
      'question': 'Which adverb means "in a disorderly or chaotic manner"?',
      'options': ['neatly', 'hastily', 'calmly', 'chaotically'],
      'correctAnswer': 'chaotically',
    },
    {
      'number': '7',
      'question': 'Choose the adverb in the sentence: "He speaks fluently in Spanish."',
      'options': ['he', 'speaks', 'fluently', 'Spanish'],
      'correctAnswer': 'fluently',
    },
    {
      'number': '8',
      'question': 'What adverb means "with great speed or velocity"?',
      'options': ['slowly', 'quickly', 'carefully', 'eagerly'],
      'correctAnswer': 'quickly',
    },
    {
      'number': '9',
      'question': 'Identify the adverb in the sentence: "She danced gracefully across the stage."',
      'options': ['she', 'danced', 'gracefully', 'stage'],
      'correctAnswer': 'gracefully',
    },
    {
      'number': '10',
      'question': 'Which adverb means "in a calm and composed manner"?',
      'options': ['anxiously', 'calmly', 'nervously', 'carelessly'],
      'correctAnswer': 'calmly',
    },
    {
      'number': '11',
      'question': 'Choose the adverb in the sentence: "They smiled happily at the news."',
      'options': ['they', 'smiled', 'happily', 'news'],
      'correctAnswer': 'happily',
    },
    {
      'number': '12',
      'question': 'What adverb means "in a foolish or ridiculous manner"?',
      'options': ['wisely', 'foolishly', 'cleverly', 'bravely'],
      'correctAnswer': 'foolishly',
    },
    {
      'number': '13',
      'question': 'Identify the adverb in the sentence: "He walked briskly in the morning air."',
      'options': ['he', 'walked', 'briskly', 'morning'],
      'correctAnswer': 'briskly',
    },
    {
      'number': '14',
      'question': 'Choose the adverb in the sentence: "She looked anxiously for her lost keys."',
      'options': ['she', 'looked', 'anxiously', 'keys'],
      'correctAnswer': 'anxiously',
    },
    {
      'number': '15',
      'question': 'What adverb means "in a relaxed or laid-back manner"?',
      'options': ['tensely', 'reluctantly', 'casually', 'easily'],
      'correctAnswer': 'casually',
    },
    {
      'number': '16',
      'question': 'Identify the adverb in the sentence: "He spoke softly to the crying child."',
      'options': ['he', 'spoke', 'softly', 'crying'],
      'correctAnswer': 'softly',
    },
    {
      'number': '17',
      'question': 'Choose the adverb in the sentence: "They worked diligently on the project."',
      'options': ['they', 'worked', 'diligently', 'project'],
      'correctAnswer': 'diligently',
    },
    {
      'number': '18',
      'question': 'What adverb means "in a hesitant or uncertain manner"?',
      'options': ['bravely', 'decisively', 'uncertainly', 'firmly'],
      'correctAnswer': 'uncertainly',
    },
    {
      'number': '19',
      'question': 'Identify the adverb in the sentence: "She spoke passionately about her beliefs."',
      'options': ['she', 'spoke', 'passionately', 'beliefs'],
      'correctAnswer': 'passionately',
    },
    {
      'number': '20',
      'question': 'Choose the adverb in the sentence: "They performed exceptionally well in the competition."',
      'options': ['they', 'performed', 'exceptionally', 'competition'],
      'correctAnswer': 'exceptionally',
    },
  ];

  String? _selectedOption;

  void _submitAnswer() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an option.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }

    if (_answeredQuestions[_currentQuestionIndex]) {
      if (_selectedOption == _questions[_currentQuestionIndex]['correctAnswer']) {
        setState(() {
          _answeredQuestions[_currentQuestionIndex] = true; // Mark question as answered
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Correct!'),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 500),
            ),
          );
          // Move to the next question if available
          if (_currentQuestionIndex < _questions.length - 1) {
            _currentQuestionIndex++;
            _selectedOption = null;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect!'),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    }

    // Check if the selected option is correct
    if (_selectedOption == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        score++; // Increment score
        _updateScoreInFirebase();
        _answeredQuestions[_currentQuestionIndex] = true; // Mark question as answered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct!'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
        // Move to the next question if available
        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
          _selectedOption = null;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect!'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  void _updateScoreInFirebase() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
        'gameData': {
          'adverb': {'score': score}, // Use a different key for verb scores
        },
      }, SetOptions(merge: true));
    }
  }

  void _getStoredData() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData =
        documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('adverb')) {
            setState(() {
              score = gameScores['adverb']['score'] ?? 0; // Default score to 0 if not found
              _currentQuestionIndex = score;  // Use score to determine current question index
              _answeredQuestions = List.generate(
                _questions.length,
                    (index) => index < score,
              );
            });
          }
        }
      }
    }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _allCorrect = false;
      score = 0;
      _selectedOption = null;
      // Update initialization of _answeredQuestions
      _answeredQuestions = List.filled(20, false);
    });
  }

  @override
  void initState() {
    super.initState();
    _getStoredData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adverb"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              "Score: $score",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
        backgroundColor: Colors.lime.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Display all question numbers
            // Wrap the row of numbers with a SingleChildScrollView
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _questions.length,
                      (index) => InkWell(
                    onTap: () {
                      if (_answeredQuestions[index]) {
                        setState(() {
                          _currentQuestionIndex = index;
                          _selectedOption = null;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _answeredQuestions[index]
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: Text(
                        _questions[index]['number'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            // Display the question
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10.0),
            // Display options
            for (String option in _questions[_currentQuestionIndex]['options'])
              RadioListTile(
                title: Text(option),
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String?;
                  });
                },
              ),
            SizedBox(height: 30),

            // Conditionally show "Restart Quiz" button
            Visibility(
              visible: _allCorrect || score == _questions.length,
              child: ElevatedButton(
                onPressed: _resetQuiz,
                child: Text('Restart Game'),
              ),
            ),

            ElevatedButton(
              onPressed: _submitAnswer,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
