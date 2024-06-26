import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SecondStory extends StatefulWidget {
  @override
  _SecondStoryState createState() => _SecondStoryState();
}

class _SecondStoryState extends State<SecondStory> {
  final FlutterTts flutterTts = FlutterTts();
  bool _playAudio = true; // Flag to control audio playback

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Proud Rose",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Swiper(
        itemCount: 7,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return SecondStory1(flutterTts: flutterTts, playAudio: _playAudio);
            case 1:
              return SecondStory2(flutterTts: flutterTts, playAudio: _playAudio);
            case 2:
              return SecondStory3(flutterTts: flutterTts, playAudio: _playAudio);
            case 3:
              return SecondStory4(flutterTts: flutterTts, playAudio: _playAudio);
            case 4:
              return SecondStory5(flutterTts: flutterTts, playAudio: _playAudio);
            case 5:
              return SecondStory6(flutterTts: flutterTts, playAudio: _playAudio);
            case 6:
              return SecondStoryMoral(flutterTts: flutterTts,);
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_playAudio ? Icons.volume_up : Icons.volume_off),
        onPressed: () {
          setState(() {
            _playAudio = !_playAudio;
            // Stop any ongoing speech when switching audio mode
            flutterTts.stop();
          });
        },
      ),
    );
  }
}


class SecondStory1 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory1({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak(
                    "Once upon a time, in a dry and sunny desert, there was a proud and beautiful rose and a sturdy cactus. "
                        "The rose was very pretty but also quite mean.",
                  );
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20),
            Text(
              "Once upon a time, in a dry and sunny desert, there was a proud and beautiful rose and a sturdy cactus. "
                  "The rose was very pretty but also quite mean.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 60),
            Image.asset("assets/story/story2/pic1.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}

class SecondStory2 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory2({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak(" It liked to tease the cactus because it didn't look as fancy. It was too busy admiring its own petals."
                    ,);
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20,),
            Text(
              "It liked to tease the cactus because it didn't look as fancy. It was too busy admiring its own petals.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 80),
            Image.asset("assets/story/story2/pic2.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}


class SecondStory3 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory3({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak("One scorching summer, there was barely any water in the desert. "
                      "The rose started to wilt and lose its beauty because it didn't have enough water to drink.",
                  );
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20,),
            Text(
              "One scorching summer, there was barely any water in the desert. "
                  "The rose started to wilt and lose its beauty because it didn't have enough water to drink.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 60),
            Image.asset("assets/story/story2/pic3.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}

class SecondStory4 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory4({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak("However, the cactus, despite not being as pretty, had stored water inside itself. "
                      "It became a lifesaver for little sparrows who came to drink from it.",
                  );
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20,),
            Text(
              "However, the cactus, despite not being as pretty, had stored water inside itself. "
                  "It became a lifesaver for little sparrows who came to drink from it.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 70),
            Image.asset("assets/story/story2/pic4.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}


class SecondStory5 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory5({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak("Feeling weak and thirsty, the rose asked the cactus for some water. "
                      "Surprisingly, the cactus gladly shared its water with the rose, even though the rose had been mean to it before. ",
                  );
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20,),
            Text(
              "Feeling weak and thirsty, the rose asked the cactus for some water. "
                  "Surprisingly, the cactus gladly shared its water with the rose, even though the rose had been mean to it before. ",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 70),
            Image.asset("assets/story/story2/pic5.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}


class SecondStory6 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const SecondStory6({Key? key, required this.flutterTts, required this.playAudio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (playAudio)
              SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak("In the end, the rose and the cactus became friends, teaching that true beauty lies in kindness, not appearances.",

                  );
                },
                child: Text('Click Here To Hear The Story'),
              ),
            SizedBox(height: 20,),
            Text(
              "In the end, the rose and the cactus became friends, teaching that true beauty lies in kindness, not appearances.",

              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 80),
            Image.asset("assets/story/story2/pic6.png", height: 230, width: 230,),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}

class SecondStoryMoral extends StatelessWidget {
  final FlutterTts flutterTts;

  const SecondStoryMoral({Key? key, required this.flutterTts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  await flutterTts.setSpeechRate(0.3);
                  await flutterTts.speak("Moral: Never judge someone based on their appearance.",
                  );
                },
                child: Text('Click Here To Hear The Moral'),
              ),
              SizedBox(height: 20,),
              Text(
                "Moral: Never judge someone based on their appearance.",
                style: TextStyle(
                  fontFamily: 'Balsamiq Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 70),
              Text(
                "try to answer the questions by clicking on this",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondQuestionsPage()),
                  );
                },
                icon: Icon(Icons.question_answer_rounded, color: Colors.lightGreen, size: 40,),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}


class SecondQuestionsPage extends StatefulWidget {
  @override
  _SecondQuestionsPageState createState() => _SecondQuestionsPageState();
}

class _SecondQuestionsPageState extends State<SecondQuestionsPage> {
  int _currentQuestionIndex = 0;
  bool _allCorrect = false; // Flag to track if all questions are answered correctly

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What are the main characters in the story?',
      'options': [
        'Rose and Sparrow',
        'Cactus and Fox',
        'Rose and Cactus',
        'Fox and Sparrow'
      ],
      'correctAnswer': 'Rose and Cactus',
    },
    {
      'question': 'Why did the rose start to wilt?',
      'options': [
        'Too much sunlight',
        'Not enough water',
        'Too much water',
        'Too many insects'
      ],
      'correctAnswer': 'Not enough water',
    },
    {
      'question': 'What did the cactus have stored inside itself?',
      'options': [
        'Sunlight',
        'Sand',
        'Water',
        'Food'
      ],
      'correctAnswer': 'Water',
    },
    {
      'question': 'What did the rose and the cactus teach?',
      'options': [
        'To be mean to others',
        'That true beauty is in kindness',
        'To judge based on appearances',
        'To stay away from each other'
      ],
      'correctAnswer': 'That true beauty is in kindness',
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
            SizedBox(height: 30,),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
