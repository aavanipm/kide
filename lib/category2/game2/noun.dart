import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NounQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  NounQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _NounQuestionsPageState createState() => _NounQuestionsPageState();
}

class _NounQuestionsPageState extends State<NounQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions

  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Which word names a person?',
      'options': ['house', 'boy', 'car', 'jump'],
      'correctAnswer': 'boy',
    },
    {
      'number': '2',
      'question': 'What word tells you about an object?',
      'options': ['sleep', 'big', 'table', 'run'],
      'correctAnswer': 'table',
    },
    {
      'number': '3',
      'question': 'Find the word that is not an action.',
      'options': ['play', 'eat', 'jump', 'dog'],
      'correctAnswer': 'dog',
    },
    {
      'number': '4',
      'question': 'Which word is a noun: "The cat is sleeping on the mat."',
      'options': ['cat', 'sleeping', 'on', 'mat'],
      'correctAnswer': 'cat',
    },
    {
      'number': '5',
      'question': 'Select the noun: "She bought a beautiful dress for the party."',
      'options': ['she', 'bought', 'beautiful', 'dress'],
      'correctAnswer': 'dress',
    },
    {
      'number': '6',
      'question': 'Find the noun in the sentence: "The sun shines brightly in the sky."',
      'options': ['sun', 'shines', 'brightly', 'sky'],
      'correctAnswer': 'sun',
    },
    {
      'number': '7',
      'question': 'Which word is a noun: "He enjoys playing soccer with his friends."',
      'options': ['enjoys', 'playing', 'soccer', 'friends'],
      'correctAnswer': 'soccer',
    },
    {
      'number': '8',
      'question': 'What kind of noun is "London"?',
      'options': ['Person', 'Place', 'Thing', 'Feeling'],
      'correctAnswer': 'Place',
    },
    {
      'number': '9',

      'question': 'Is "happiness" a countable or uncountable noun?',
      'options': [
        'Countable (one happiness, two happinesses)',
        'Countable (happy, happier, happiest)',
        'Uncountable'
      ],
      'correctAnswer': 'Uncountable',
    },
    {
      'number': '10',
      'question': 'Change the sentence "The dog barks" to have a plural noun as the subject. Which word should replace "dog"?',
      'options': ['Dogs', 'Barks', 'Loudly', 'Yard'],
      'correctAnswer': 'Dogs',
    },
    {
      'number': '11',
      'question': 'What is the collective noun for a group of firefighters?',
      'options': ['Pack', 'Team', 'Pride', 'Herd'],
      'correctAnswer': 'Team',
    },
    {
      'number': '12',
      'question': 'Identify the proper noun in the sentence: "The teacher explained the parts of speech."',
      'options': ['teacher', 'explained', 'parts', 'speech'],
      'correctAnswer': 'teacher',
    },
    {
      'number': '13',
      'question': 'What is the possessive form of the noun "cat"?',
      'options': ['Cats', 'Catty', "Cat's", 'Scratch'],
      'correctAnswer': "Cat's",
    },
    {
      'number': '14',
      'question': 'The sentence "The delicious cake disappeared quickly" has two nouns. Which noun describes the other noun?',
      'options': ['The', 'delicious', 'cake', 'quickly'],
      'correctAnswer': 'delicious',
    },
    {
      'number': '15',
      'question': 'Can a proper noun also be a common noun? (e.g., Jupiter, the jupiter of the team)',
      'options': ['Yes', 'No'],
      'correctAnswer': 'Yes',
    },
    {
      'number': '16',
      'question': 'What is the compound noun formed by "butter" and "fly"?',
      'options': ['Butterful', 'Butterflight', 'Butterfly', 'Butterglide'],
      'correctAnswer': 'Butterfly',
    },
    {
      'number': '17',
      'question': 'Fill in the blank with a concrete noun: The artist used her paints and brushes to create a beautiful _____.',
      'options': ['Feeling', 'Melody', 'Painting', 'Victory'],
      'correctAnswer': 'Painting',
    },
    {
      "number": "18",
      "question": "What is the abstract noun for the quality of being large?",
      "options": ["Bigness", "Large", "Largeness", "Bigly"],
      "correctAnswer": "Largeness"
    },
    {
      "number": "19",
      "question": "Identify the collective noun for a group of people working together on a project:",
      "options": ["Team", "Audience", "Crowd", "Family"],
      "correctAnswer": "Team"
    },
    {
      "number": "20",
      "question": "Change the sentence 'The bird sings a song' to the plural form. Which word should be replaced?",
      "options": ["The", "bird", "sings", "song"],
      "correctAnswer": "bird"
    }
    // Add more questions here
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
          'noun': {'score': score}, // Use a different key for verb scores
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
          if (gameScores.containsKey('noun')) {
            setState(() {
              score = gameScores['noun']['score'] ?? 0; // Default score to 0 if not found
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
        title: Text("Noun"),
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
