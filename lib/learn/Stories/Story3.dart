import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ThirdStory extends StatefulWidget {
  @override
  _ThirdStoryState createState() => _ThirdStoryState();
}

class _ThirdStoryState extends State<ThirdStory> {
  final FlutterTts flutterTts = FlutterTts();
  bool _playAudio = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Bear and the Two Friends",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Swiper(
        itemCount: 7,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return ThirdStory1(flutterTts: flutterTts, playAudio: _playAudio);
            case 1:
              return ThirdStory2(flutterTts: flutterTts, playAudio: _playAudio);
            case 2:
              return ThirdStory3(flutterTts: flutterTts, playAudio: _playAudio);
            case 3:
              return ThirdStory4(flutterTts: flutterTts, playAudio: _playAudio);
            case 4:
              return ThirdStory5(flutterTts: flutterTts, playAudio: _playAudio);
            case 5:
              return ThirdStory6(flutterTts: flutterTts, playAudio: _playAudio);
            case 6:
              return ThirdStoryMoral(flutterTts: flutterTts,);
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
            flutterTts.stop();
          });
        },
      ),
    );
  }
}

class ThirdStory1 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory1({Key? key, required this.flutterTts, required this.playAudio})
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
                  "Once upon a time, there were two friends named Alex and Sam. "
                      "They decided to go for a walk in the forest. Since the forest could be dangerous, they promised to stick together.",
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20),
            Text(
              "Once upon a time, there were two friends named Alex and Sam. "
                  "They decided to go for a walk in the forest. Since the forest could be dangerous, they promised to stick together.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 60),
            Image.asset("assets/story/story3/pic1.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}

class ThirdStory2 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory2({Key? key, required this.flutterTts, required this.playAudio})
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
                await flutterTts.speak(
                  "As they were walking, they suddenly saw a big bear coming towards them!",
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20,),
            Text(
              "As they were walking, they suddenly saw a big bear coming towards them!",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 100),
            Image.asset("assets/story/story3/pic2.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}


class ThirdStory3 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory3({Key? key, required this.flutterTts, required this.playAudio})
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
                await flutterTts.speak(
                  "Without thinking, Alex quickly climbed up a tree to hide, leaving Sam all alone on the ground.",
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20,),
            Text(
              "Without thinking, Alex quickly climbed up a tree to hide, leaving Sam all alone on the ground.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 90),
            Image.asset("assets/story/story3/pic3.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}

class ThirdStory4 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory4({Key? key, required this.flutterTts, required this.playAudio})
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
                await flutterTts.speak(
                  "Sam got an idea and remembered that pretending to be still might make the bear think they were not a threat. "
                      "So, Sam pretended to be dead." ,
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20,),
            Text(
              "Sam got an idea and remembered that pretending to be still might make the bear think they were not a threat. "
                  "So, Sam pretended to be dead." ,
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 90),
            Image.asset("assets/story/story3/pic4.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}


class ThirdStory5 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory5({Key? key, required this.flutterTts, required this.playAudio})
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
                await flutterTts.speak(
                  "The bear came up to him, sniffed around, and then went away. Phew!",
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20,),
            Text(
              "The bear came up to him, sniffed around, and then went away. Phew!",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 90),
            Image.asset("assets/story/story3/pic5.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}


class ThirdStory6 extends StatelessWidget {
  final FlutterTts flutterTts;
  final bool playAudio;

  const ThirdStory6({Key? key, required this.flutterTts, required this.playAudio})
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
                await flutterTts.speak(
                  "When Alex came down from the tree, he asked Sam what happened. Sam replied,"
                      "The bear didn't say anything, but it taught me something important: "
                      "a true friend will always stick with you, no matter what.",
                );
              },
              child: Text('Click Here To Hear The Story'),
            ),
            SizedBox(height: 20,),
            Text(
              "When Alex came down from the tree, he asked Sam what happened. Sam replied,"
                  "The bear didn't say anything, but it taught me something important: "
                  "a true friend will always stick with you, no matter what.",
              style: TextStyle(
                fontFamily: 'Balsamiq Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 80),
            Image.asset("assets/story/story3/pic6.png", height: 230, width: 230,),
          ],
        ),
      ),
    );
  }
}

class ThirdStoryMoral extends StatelessWidget {
  final FlutterTts flutterTts;

  const ThirdStoryMoral({Key? key, required this.flutterTts}) : super(key: key);

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
                  await flutterTts.speak(
                    "Moral: Real friends stay loyal and help each other when things get tough.",

                  );
                },
                child: Text('Click Here To Hear The Moral'),
              ),
              SizedBox(height: 20,),
              Text(
                "Moral: Real friends stay loyal and help each other when things get tough.",
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
                    MaterialPageRoute(builder: (context) => ThirdQuestionsPage()),
                  );
                },
                icon: Icon(Icons.question_answer_rounded, color: Colors.lightGreen, size: 40,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ThirdQuestionsPage extends StatefulWidget {
  const ThirdQuestionsPage({super.key});

  @override
  State<ThirdQuestionsPage> createState() => _ThirdQuestionsPageState();
}

class _ThirdQuestionsPageState extends State<ThirdQuestionsPage> {

  int _currentQuestionIndex = 0;
  bool _allCorrect = false;

  List<Map<String, dynamic>> _questions = [
    {
      'question' : 'What were the names of the two friends?',
      'options' : [
        'Alex and Jerry',
        'John and Sam',
        'Bob and John',
        'Alex and Sam',
      ],
      'correctAnswer' : 'Alex and Sam',
    },
    {
      'question' : 'What were the two friends doing in the forest?',
      'options' : [
        'Playing hide and seek',
        'Walking',
        'Collecting berries',
        'Building a fort'
      ],
      'correctAnswer' : 'Walking',
    },
    {
      'question' : 'Why did Alex climb up a tree?',
      'options' : [
        'To play a game',
        'To pick fruits',
        'To get a better view',
        'To hide from the bear',
      ],
      'correctAnswer' : 'To hide from the bear',
    },
    {
      'question' : 'What did the bear do when it approached Sam?',
      'options' : [
        'Sniffed around',
        'Ran away',
        'Climbed a tree',
        'Started talking',
      ],
      'correctAnswer' : 'Sniffed around',
    },
    {
      'question' : 'What lesson did Sam share with Alex after the bear incident?',
      'options' : [
        'Bears are not to be feared',
        'True friendship is about loyalty',
        'Sharing food with bears can make them go away',
        'Bears are friendly creatures',
      ],
      'correctAnswer' : 'True friendship is about loyalty',
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
          _allCorrect = true;
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
