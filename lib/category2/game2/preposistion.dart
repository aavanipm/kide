import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrepositionQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  PrepositionQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _PrepositionQuestionsPageState createState() => _PrepositionQuestionsPageState();
}

class _PrepositionQuestionsPageState extends State<PrepositionQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions

  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Which word represents a location relationship?',
      'options': ['house', 'jump', 'in', 'book'],
      'correctAnswer': 'in',
    },
    {
      'number': '2',
      'question': 'What preposition is used to express movement to a specific location?',
      'options': ['on', 'over', 'to', 'under'],
      'correctAnswer': 'to',
    },
    {
      'number': '3',
      'question': 'Find the preposition in the sentence: "The cat is under the table."',
      'options': ['cat', 'is', 'under', 'table'],
      'correctAnswer': 'under',
    },
    {
      'number': '4',
      'question': 'Choose the preposition in the sentence: "She walked _____ the bridge."',
      'options': ['through', 'on', 'in', 'over'],
      'correctAnswer': 'on',
    },
    {
      'number': '5',
      'question': 'Identify the preposition: "The book is beside the lamp."',
      'options': ['book', 'is', 'beside', 'lamp'],
      'correctAnswer': 'beside',
    },
    {
      'number': '6',
      'question': 'What preposition is missing in the sentence: "The keys are ____ the table."',
      'options': ['above', 'on', 'in', 'under'],
      'correctAnswer': 'on',
    },
    {
      'number': '7',
      'question': 'Choose the correct preposition: "The cat jumped ____ the fence."',
      'options': ['above', 'under', 'on', 'over'],
      'correctAnswer': 'over',
    },
    {
      'number': '8',
      'question': 'Find the preposition: "The pencil rolled beneath the desk."',
      'options': ['pencil', 'rolled', 'beneath', 'desk'],
      'correctAnswer': 'beneath',
    },
    {
      'number': '9',
      'question': 'Which preposition is correct: "She was sitting ____ the sofa."',
      'options': ['at', 'on', 'in', 'by'],
      'correctAnswer': 'on',
    },
    {
      'number': '10',
      'question': 'Choose the preposition: "He stood in front of the door."',
      'options': ['stood', 'in', 'front', 'door'],
      'correctAnswer': 'in',
    },
    {
      'number': '11',
      'question': 'Find the preposition: "The ball is between the two trees."',
      'options': ['ball', 'is', 'between', 'two'],
      'correctAnswer': 'between',
    },
    {
      'number': '12',
      'question': 'Which preposition completes the sentence: "He jumped ____ the river."',
      'options': ['over', 'on', 'by', 'in'],
      'correctAnswer': 'over',
    },
    {
      'number': '13',
      'question': 'Identify the preposition in the sentence: "The bird flew above the clouds."',
      'options': ['bird', 'flew', 'above', 'clouds'],
      'correctAnswer': 'above',
    },
    {
      'number': '14',
      'question': 'Choose the correct preposition: "The key is inside the box."',
      'options': ['key', 'is', 'inside', 'box'],
      'correctAnswer': 'inside',
    },
    {
      'number': '15',
      'question': 'Find the preposition: "The rabbit ran around the tree."',
      'options': ['rabbit', 'ran', 'around', 'tree'],
      'correctAnswer': 'around',
    },
    {
      'number': '16',
      'question': 'Which preposition is correct: "The cat is sleeping beneath the table."',
      'options': ['cat', 'is', 'sleeping', 'beneath'],
      'correctAnswer': 'beneath',
    },
    {
      'number': '17',
      'question': 'Identify the preposition in the sentence: "She walked past the old house."',
      'options': ['walked', 'past', 'old', 'house'],
      'correctAnswer': 'past',
    },
    {
      'number': '18',
      'question': 'Choose the correct preposition: "The fish swim in the pond."',
      'options': ['fish', 'swim', 'in', 'pond'],
      'correctAnswer': 'in',
    },
    {
      'number': '19',
      'question': 'Which preposition is missing: "The cat is sitting ____ the chair."',
      'options': ['above', 'by', 'in', 'on'],
      'correctAnswer': 'on',
    },
    {
      'number': '20',
      'question': 'Find the preposition: "He walked through the door."',
      'options': ['walked', 'through', 'the', 'door'],
      'correctAnswer': 'through',
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Question already answered.'),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
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
          'preposition': {'score': score}, // Use a different key for verb scores
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
          if (gameScores.containsKey('preposition')) {
            setState(() {
              score = gameScores['preposition']['score'] ?? 0; // Default score to 0 if not found
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
        title: Text("Preposition"),
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
