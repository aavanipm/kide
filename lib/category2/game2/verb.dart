import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category2/congratz.dart';

class VerbQuestionsPage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  VerbQuestionsPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _VerbQuestionsPageState createState() => _VerbQuestionsPageState();
}

class _VerbQuestionsPageState extends State<VerbQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly
  int score = 0;
  List<bool> _answeredQuestions = List.filled(20, false); // Track answered questions


  List<Map<String, dynamic>> _questions = [
    {
      'number': '1',
      'question': 'Which word represents an action?',
      'options': ['house', 'car', 'book', 'jump'],
      'correctAnswer': 'jump',
    },
    {
      'number': '2',
      'question': 'Find the verb in the sentence: "She sings beautifully."',
      'options': ['she', 'sings', 'beautifully', 'song'],
      'correctAnswer': 'sings',
    },
    {
      'number': '3',
      'question': 'What word describes a continuous action?',
      'options': ['run', 'eating', 'sleep', 'play'],
      'correctAnswer': 'eating',
    },
    {
      'number': '4',
      'question': 'Which word is a verb: "The cat is sleeping on the mat."',
      'options': ['cat', 'sleeping', 'on', 'mat'],
      'correctAnswer': 'sleeping',
    },
    {
      'number': '5',
      'question': 'Select the verb: "She bought a beautiful dress for the party."',
      'options': ['she', 'bought', 'beautiful', 'dress'],
      'correctAnswer': 'bought',
    },
    {
      'number': '6',
      'question': 'Find the action word in the sentence: "The sun shines brightly in the sky."',
      'options': ['sun', 'shines', 'brightly', 'sky'],
      'correctAnswer': 'shines',
    },
    {
      'number': '7',
      'question': 'Choose the verb in the sentence: "They are playing football in the park."',
      'options': ['they', 'are', 'playing', 'football'],
      'correctAnswer': 'playing',
    },
    {
      'number': '8',
      'question': 'Identify the action word in the sentence: "The dog barks loudly at night."',
      'options': ['dog', 'barks', 'loudly', 'night'],
      'correctAnswer': 'barks',
    },
    {
      'number': '9',
      'question': 'Which word is a verb: "The children are laughing at the funny joke."',
      'options': ['children', 'laughing', 'funny', 'joke'],
      'correctAnswer': 'laughing',
    },
    {
      'number': '10',
      'question': 'Choose the verb: "He reads a book every evening."',
      'options': ['he', 'reads', 'book', 'evening'],
      'correctAnswer': 'reads',
    },
    {
      'number': '11',
      'question': 'Identify the action word in the sentence: "She swims in the pool every morning."',
      'options': ['she', 'swims', 'pool', 'morning'],
      'correctAnswer': 'swims',
    },
    {
      'number': '12',
      'question': 'Select the verb: "They play tennis on Sundays."',
      'options': ['they', 'play', 'tennis', 'Sundays'],
      'correctAnswer': 'play',
    },
    {
      'number': '13',
      'question': 'Choose the action word: "He dances gracefully at the party."',
      'options': ['he', 'dances', 'gracefully', 'party'],
      'correctAnswer': 'dances',
    },
    {
      'number': '14',
      'question': 'Identify the verb: "The cat sleeps all day."',
      'options': ['cat', 'sleeps', 'all', 'day'],
      'correctAnswer': 'sleeps',
    },
    {
      'number': '15',
      'question': 'Find the action word in the sentence: "The birds chirp in the morning."',
      'options': ['birds', 'chirp', 'morning', 'in'],
      'correctAnswer': 'chirp',
    },
    {
      'number': '16',
      'question': 'Select the verb: "She writes a letter to her friend."',
      'options': ['she', 'writes', 'letter', 'friend'],
      'correctAnswer': 'writes',
    },
    {
      'number': '17',
      'question': 'Choose the action word: "He cooks delicious food for his family."',
      'options': ['he', 'cooks', 'delicious', 'food'],
      'correctAnswer': 'cooks',
    },
    {
      'number': '18',
      'question': 'Identify the verb: "The baby cries when she is hungry."',
      'options': ['baby', 'cries', 'hungry', 'when'],
      'correctAnswer': 'cries',
    },
    {
      'number': '19',
      'question': 'Find the action word in the sentence: "The teacher explains the lesson to the students."',
      'options': ['teacher', 'explains', 'lesson', 'students'],
      'correctAnswer': 'explains',
    },
    {
      'number': '20',
      'question': 'Select the verb: "They hike in the mountains every summer."',
      'options': ['they', 'hike', 'mountains', 'summer'],
      'correctAnswer': 'hike',
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
          'verb': {'score': score}, // Use a different key for verb scores
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
          if (gameScores.containsKey('verb')) {
            setState(() {
              score = gameScores['verb']['score'] ?? 0; // Default score to 0 if not found
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
        title: Text("Verbs"),
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
