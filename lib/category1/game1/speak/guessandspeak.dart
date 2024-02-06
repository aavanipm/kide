import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuessandSpeakGame extends StatefulWidget {
  const GuessandSpeakGame({Key? key}) : super(key: key);

  @override
  _GuessandSpeakGameState createState() => _GuessandSpeakGameState();
}

class _GuessandSpeakGameState extends State<GuessandSpeakGame> {
  final List<AnimalItem> animals = [
    AnimalItem(name: 'Lion', imagePath: 'assets/animals/lion.png'),
    AnimalItem(name: 'Dog', imagePath: 'assets/animals/dog.png'),
  ];

  int currentIndex = 0;
  int score = 0;
  late stt.SpeechToText _speech;
  String spokenWord = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _speech.initialize(onStatus: _statusListener);
  }

  void _statusListener(String status) {
    print("Speech recognition status: $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speak Game'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const Text(
              'Guess name!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Row(
                children: [
                  _buildAnimalCard(animals[currentIndex]),
                  IconButton(
                    onPressed: () {
                      _startListening();
                    },
                    icon: const Icon(Icons.mic),
                  ),
                  IconButton(
                    onPressed: () {
                      _nextAnimal();
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            Text(
              spokenWord.isEmpty ? 'Speak...' : spokenWord,
              style: TextStyle(
                fontSize: 20,
                color: spokenWord.toLowerCase() == animals[currentIndex].name.toLowerCase() && spokenWord.isNotEmpty ? Colors.blue : Colors.black,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _speech.stop();
                _checkAnswer(animals[currentIndex].name);
              },
              child: const Text('Check Answer'),
            ),
            const SizedBox(height: 20),
            Text('Score: $score'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalCard(AnimalItem animal) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(animal.imagePath, height: 200, width: 170),
        ],
      ),
    );
  }

  void _nextAnimal() {
    setState(() {
      currentIndex = (currentIndex + 1) % animals.length;
      spokenWord = '';
    });
  }

  void _checkAnswer(String guessedAnimal) {
    String correctAnimalName = animals[currentIndex].name.toLowerCase();
    String spokenWordLower = spokenWord.toLowerCase();

    // Remove any leading or trailing whitespace
    guessedAnimal = guessedAnimal.trim();
    spokenWordLower = spokenWordLower.trim();

    if (spokenWordLower == correctAnimalName || _isSimilar(spokenWordLower, correctAnimalName)) {
      setState(() {
        score++;
        _nextAnimal();
      });
    } else {
    }
  }

  bool _isSimilar(String a, String b) {

    return a.length == b.length || a.contains(b) || b.contains(a);
  }


  void _startListening() {
    _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          print('Speech recognition result: ${result.recognizedWords}');
          setState(() {
            spokenWord = result.recognizedWords;
          });
          _checkAnswer(result.recognizedWords);
        }
      },
    );
  }
}

class AnimalItem {
  final String name;
  final String imagePath;

  AnimalItem({required this.name, required this.imagePath});
}