import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class ThirdStory extends StatelessWidget {
  const ThirdStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Bear and the Two Friends",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Swiper(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index){
          switch(index){
            case 0:
              return ThirdStory1();
            case 1:
              return ThirdStory2();
            case 2:
              return ThirdStory3();
            case 3:
              return ThirdStory4();
            case 4:
              return ThirdStory5();
            case 5:
              return ThirdStory6();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class ThirdStory1 extends StatelessWidget {
  const ThirdStory1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
            "Once upon a time, there were two friends named Alex and Sam. "
                "They decided to go for a walk in the forest. Since the forest could be dangerous, they promised to stick together.",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStory2 extends StatelessWidget {
  const ThirdStory2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "As they were walking, they suddenly saw a big bear coming towards them!",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStory3 extends StatelessWidget {
  const ThirdStory3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Without thinking, Alex quickly climbed up a tree to hide, leaving Sam all alone on the ground.",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStory4 extends StatelessWidget {
  const ThirdStory4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Sam got an idea and remembered that pretending to be still might make the bear think they were not a threat. "
            "So, Sam pretended to be dead." ,
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStory5 extends StatelessWidget {
  const ThirdStory5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "The bear came up to him, sniffed around, and then went away. Phew!",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStory6 extends StatelessWidget {
  const ThirdStory6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "When Alex came down from the tree, he asked Sam what happened. Sam replied,"
                "The bear didn't say anything, but it taught me something important: "
                "a true friend will always stick with you, no matter what.",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class ThirdStoryMoral extends StatelessWidget {
  const ThirdStoryMoral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
              "Real friends stay loyal and help each other when things get tough.",
            style: TextStyle(
              fontFamily: 'Balsamiq Sans',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20,),
          IconButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>ThirdQuestionsPage()),
                );
              },
              icon: Icon(Icons.question_answer, color: Colors.lightGreen,),
          )
        ],
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
  String? _selectedOption;

  List<Map<String, dynamic>> _questions = [
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
      'question' : 'What were the names of the two friends?',
      'options' : [
        'Alex and Jerry',
        'John and Sam',
        'Bob and John',
        'Alex and Sam',
      ],
      'correctAnswer' : 'Alex and Jerry',
    },
  ];

  void _submitAnswer() {
    if(_selectedOption == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an option"),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }
    if (_selectedOption == _questions[_currentQuestionIndex]['correctAnswer']){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
        if (_currentQuestionIndex < _questions.length - 1){
          _currentQuestionIndex++;
          _selectedOption = null;
        } else {
          _allCorrect = true;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allCorrect ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Congratulations! You answered all questions correctly!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: Text("OK"))
        ],
      ) : Column(
        children: [
          Text(
            _questions[_currentQuestionIndex]['question'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          for(String option in _questions[_currentQuestionIndex]['options'])
            RadioListTile(
                value: option,
                groupValue: _selectedOption,
                onChanged: (value){
                  setState(() {
                    _selectedOption = value as String?;
                  });
                }
            ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: _submitAnswer,
              child: Text("Submit")
          )
        ],
      )
    );
  }
}
