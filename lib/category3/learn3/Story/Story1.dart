import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class FirstStory extends StatelessWidget {
  const FirstStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Fox and the Grapes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Swiper(
        itemCount: 5,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch(index){
            case 0:
              return FirstStory1();
            case 1:
              return FirstStory2();
            case 2:
              return FirstStory3();
            case 3:
              return FirstStory4();
            case 4:
              return FirstStoryMoral();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class FirstStory1 extends StatelessWidget {
  const FirstStory1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Once there was a hungry fox who was searching for food. He looked everywhere but couldn't find anything to eat.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstStory2 extends StatelessWidget {
  const FirstStory2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Then, he came across a farmer's wall where he saw some big, purple, juicy grapes hanging.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstStory3 extends StatelessWidget {
  const FirstStory3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "The fox tried jumping to reach the grapes, but no matter how hard he tried, he couldn't reach them.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstStory4 extends StatelessWidget {
  const FirstStory4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "After many attempts, he gave up and went back home. On the way, he told himself that the grapes must have been sour anyway.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstStoryMoral extends StatelessWidget {
  const FirstStoryMoral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Align contents vertically at the center
            children: [
              Text(
                "Moral: Don't give up too easily. Keep trying, and you might find a way to overcome challenges.",
                style: TextStyle(
                  fontFamily: 'Balsamiq Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstQuestionsPage()),
                  );
                },
                icon: Icon(Icons.question_answer, color: Colors.lightGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FirstQuestionsPage extends StatefulWidget {
  @override
  _FirstQuestionsPageState createState() => _FirstQuestionsPageState();
}

class _FirstQuestionsPageState extends State<FirstQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What was the fox searching for?',
      'options': ['Food', 'Toys', 'Friends', 'Books'],
      'correctAnswer': 'Food',
    },
    {
      'question': 'Where did the fox find the grapes?',
      'options': ['In the forest', 'At the farmer\'s wall', 'In a cave', 'In a river'],
      'correctAnswer': 'At the farmer\'s wall',
    },
    {
      'question': 'Why couldn\'t the fox reach the grapes?',
      'options': ['They were too high', 'They were too low', 'They were too sour', 'They were too green'],
      'correctAnswer': 'They were too high',
    },
    {
      'question': 'What did the fox think about the grapes?',
      'options': ['They were delicious', 'They were sour', 'They were rotten', 'They were magical'],
      'correctAnswer': 'They were sour',
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

    if (_selectedOption == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct!'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
          _selectedOption = null;
        } else {
          _allCorrect = true; // Set flag to true when all questions are answered correctly
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _allCorrect
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations! You answered all questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Navigate back to home screen
              },
              child: Text('OK'),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
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
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
