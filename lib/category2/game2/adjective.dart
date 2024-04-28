import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdjectiveQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  AdjectiveQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _AdjectiveQuestionsPageState createState() => _AdjectiveQuestionsPageState();
}

class _AdjectiveQuestionsPageState extends State<AdjectiveQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions

  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Which word describes a noun or pronoun?',
      'options': ['jump', 'quickly', 'bookish', 'apple'],
      'correctAnswer': 'bookish',
    },
    {
      'number': '2',
      'question': 'Identify the adjective in the sentence: "She has a beautiful dress."',
      'options': ['she', 'has', 'beautiful', 'dress'],
      'correctAnswer': 'beautiful',
    },
    {
      'number': '3',
      'question': 'What adjective means "having a pleasant smell"?',
      'options': ['stinky', 'fragrant', 'rotten', 'loud'],
      'correctAnswer': 'fragrant',
    },
    {
      'number': '4',
      'question': 'Choose the adjective in the sentence: "He is a smart student."',
      'options': ['he', 'is', 'smart', 'student'],
      'correctAnswer': 'smart',
    },
    {
      'number': '5',
      'question': 'Identify the adjective in the sentence: "The tall building stood out against the sky."',
      'options': ['tall', 'building', 'stood', 'sky'],
      'correctAnswer': 'tall',
    },
    {
      'number': '6',
      'question': 'Which adjective means "showing great courage or bravery"?',
      'options': ['cowardly', 'timid', 'brave', 'careless'],
      'correctAnswer': 'brave',
    },
    {
      'number': '7',
      'question': 'Read the sentence: '"She wore a red dress to the party."' Which word describes the dress?"',
      'options': ['she', 'wore', 'red', 'party'],
      'correctAnswer': 'red',
    },
    {
      'number': '8',
      'question': 'What adjective means "feeling sad or unhappy"?',
      'options': ['happy', 'cheerful', 'melancholy', 'joyful'],
      'correctAnswer': 'melancholy',
    },
    {
      'number': '9',
      'question': 'Identify the adjective in the sentence: "The old man lived in a small house."',
      'options': ['old', 'man', 'lived', 'small'],
      'correctAnswer': 'small',
    },
    {
      'number': '10',
      'question': 'Which adjective means "showing kindness or goodwill"?',
      'options': ['rude', 'unkind', 'friendly', 'mean'],
      'correctAnswer': 'friendly',
    },
    {
      'number': '11',
      'question': 'Choose the adjective in the sentence: "The bright sun shone in the clear sky."',
      'options': ['bright', 'sun', 'shone', 'clear'],
      'correctAnswer': 'bright',
    },
    {
      'number': '12',
      'question': 'What adjective means "showing great joy or pleasure"?',
      'options': ['sad', 'depressed', 'ecstatic', 'miserable'],
      'correctAnswer': 'ecstatic',
    },
    {
      'number': '13',
      'question': 'Identify the adjective in the sentence: "She received an expensive gift for her birthday."',
      'options': ['she', 'received', 'expensive', 'gift'],
      'correctAnswer': 'expensive',
    },
    {
      'number': '14',
      'question': 'Choose the adjective in the sentence: "The big dog chased the small cat."',
      'options': ['big', 'dog', 'chased', 'small'],
      'correctAnswer': 'small',
    },
    {
      'number': '15',
      'question': 'What adjective means "having a pleasant taste or flavor"?',
      'options': ['bland', 'spicy', 'sweet', 'sour'],
      'correctAnswer': 'sweet',
    },
    {
      'number': '16',
      'question': 'Identify the adjective in the sentence: "The young boy played with his favorite toy."',
      'options': ['young', 'boy', 'played', 'favorite'],
      'correctAnswer': 'favorite',
    },
    {
      'number': '17',
      'question': 'Choose the adjective in the sentence: "The old tree provided shade on hot days."',
      'options': ['old', 'tree', 'provided', 'hot'],
      'correctAnswer': 'old',
    },
    {
      'number': '18',
      'question': 'What adjective means "showing great determination or resolve"?',
      'options': ['weak', 'determined', 'lazy', 'tired'],
      'correctAnswer': 'determined',
    },
    {
      'number': '19',
      'question': 'Identify the adjective in the sentence: "The black cat crossed the street."',
      'options': ['black', 'cat', 'crossed', 'street'],
      'correctAnswer': 'black',
    },
    {
      'number': '20',
      'question': 'Choose the adjective in the sentence: "The cozy cabin nestled among the trees."',
      'options': ['cozy', 'cabin', 'nestled', 'trees'],
      'correctAnswer': 'cozy',
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
          'adjective': {'score': score}, // Use a different key for verb scores
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
          if (gameScores.containsKey('adjective')) {
            setState(() {
              score = gameScores['adjective']['score'] ?? 0; // Default score to 0 if not found
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
        title: Text("Adjective"),
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
