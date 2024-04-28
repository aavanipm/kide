import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PronounQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  PronounQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _PronounQuestionsPageState createState() => _PronounQuestionsPageState();
}

class _PronounQuestionsPageState extends State<PronounQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions

  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Select the pronoun in the sentence: "He went to the store to buy groceries."',
      'options': ['he', 'went', 'store', 'buy'],
      'correctAnswer': 'he',
    },
    {
      'number': '2',
      'question': 'Which word is a pronoun: "She is reading a book."',
      'options': ['she', 'reading', 'book', 'is'],
      'correctAnswer': 'she',
    },
    {
      'number': '3',
      'question': 'Find the pronoun in the sentence: "They are going to the park."',
      'options': ['they', 'are', 'going', 'park'],
      'correctAnswer': 'they',
    },
    {
      'number': '4',
      'question': 'Select the pronoun in the sentence: "We like to play soccer."',
      'options': ['we', 'like', 'play', 'soccer'],
      'correctAnswer': 'we',
    },
    {
      'number': '5',
      'question': 'Identify the pronoun in the sentence: "It is raining outside."',
      'options': ['it', 'is', 'raining', 'outside'],
      'correctAnswer': 'it',
    },
    {
      'number': '6',
      'question': 'Choose the pronoun in the sentence: "You should study for the exam."',
      'options': ['you', 'should', 'study', 'exam'],
      'correctAnswer': 'you',
    },
    {
      'number': '7',
      'question': 'Select the pronoun in the sentence: "She gave me a present for my birthday."',
      'options': ['she', 'gave', 'me', 'present'],
      'correctAnswer': 'me',
    },
    {
      'number': '8',
      'question': 'Find the pronoun in the sentence: "He is going to the beach with his friends."',
      'options': ['he', 'is', 'going', 'beach'],
      'correctAnswer': 'he',
    },
    {
      'number': '9',
      'question': 'Choose the pronoun in the sentence: "I am going to the party tonight."',
      'options': ['i', 'am', 'going', 'party'],
      'correctAnswer': 'i',
    },
    {
      'number': '10',
      'question': 'Identify the pronoun in the sentence: "You should call your mom."',
      'options': ['you', 'should', 'call', 'mom'],
      'correctAnswer': 'you',
    },
    {
      'number': '11',
      'question': 'Select the pronoun in the sentence: "We are going to the movies tonight."',
      'options': ['we', 'are', 'going', 'movies'],
      'correctAnswer': 'we',
    },
    {
      'number': '12',
      'question': 'Choose the pronoun in the sentence: "They need to finish their homework."',
      'options': ['they', 'need', 'finish', 'homework'],
      'correctAnswer': 'they',
    },
    {
      'number': '13',
      'question': 'Find the pronoun in the sentence: "It is important to eat healthy food."',
      'options': ['it', 'is', 'important', 'eat'],
      'correctAnswer': 'it',
    },
    {
      'number': '14',
      'question': 'Identify the pronoun in the sentence: "She is coming to the party with us."',
      'options': ['she', 'is', 'coming', 'party'],
      'correctAnswer': 'us',
    },
    {
      'number': '15',
      'question': 'Choose the pronoun in the sentence: "You should always be kind to others."',
      'options': ['you', 'should', 'always', 'kind'],
      'correctAnswer': 'you',
    },
    {
      'number': '16',
      'question': 'Select the pronoun in the sentence: "He forgot to bring his umbrella."',
      'options': ['he', 'forgot', 'bring', 'umbrella'],
      'correctAnswer': 'he',
    },
    {
      'number': '17',
      'question': 'Find the pronoun in the sentence: "She is going to visit her grandparents."',
      'options': ['she', 'is', 'going', 'visit'],
      'correctAnswer': 'she',
    },
    {
      'number': '18',
      'question': 'Choose the pronoun in the sentence: "We have to finish our project by tomorrow."',
      'options': ['we', 'have', 'finish', 'project'],
      'correctAnswer': 'we',
    },
    {
      'number': '19',
      'question': 'Identify the pronoun in the sentence: "He needs to buy a new phone."',
      'options': ['he', 'needs', 'buy', 'phone'],
      'correctAnswer': 'he',
    },
    {
      'number': '20',
      'question': 'Choose the pronoun in the sentence: "They are going to the beach for vacation."',
      'options': ['they', 'are', 'going', 'beach'],
      'correctAnswer': 'they',
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
          'pronoun': {'score': score}, // Use a different key for verb scores
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
          if (gameScores.containsKey('pronoun')) {
            setState(() {
              score = gameScores['pronoun']['score'] ?? 0; // Default score to 0 if not found
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
        title: Text("Pronoun"),
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
