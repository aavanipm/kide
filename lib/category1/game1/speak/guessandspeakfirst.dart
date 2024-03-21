import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GuesandSpeFirst extends StatefulWidget {
  const GuesandSpeFirst({Key? key}) : super(key: key);

  @override
  _GuesandSpeFirstState createState() => _GuesandSpeFirstState();
}

class _GuesandSpeFirstState extends State<GuesandSpeFirst> {
  final List<AnimalItem> animals = [
    AnimalItem(name: 'Lion', imagePath: 'assets/animals/lion.png'),
    // AnimalItem(name: 'Dog', imagePath: 'assets/animals/dog.png'),
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
        title: Row(
          children: [
            Text("Level 1"),
            SizedBox(width: 170,),
            Text("Score: $score"),
          ],
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: _buildAnimalCard(animals[currentIndex]),
          ),
          Positioned( // Position the mic button at the bottom
            bottom: 200.0, // Adjust margin from bottom as needed
            right: 800.0, // Adjust margin from right as needed
            left: 200.0,
            child: IconButton(
              onPressed: () => _startListening(),
              icon: Icon(Icons.mic, size: 30,),
            ),
          ),
        ],
      ),
      // const SizedBox(height: 40,),
      // Row(
      //   children: [
      //     _buildAnimalCard(animals[currentIndex]),
      //     SizedBox(height: 300,),
      //     Center(
      //       child: IconButton(
      //         onPressed: () {
      //           _startListening();
      //         },
      //         icon: const Icon(Icons.mic),
      //       ),
      //     ),
      //   ],
      // ),
      // Text(
      //   spokenWord.isEmpty ? 'Speak...' : spokenWord,
      //   style: TextStyle(
      //     fontSize: 20,
      //     color: spokenWord.toLowerCase() == animals[currentIndex].name.toLowerCase() && spokenWord.isNotEmpty ? Colors.blue : Colors.black,
      //   ),
      // ),

      // ElevatedButton(
      //   onPressed: () {
      //     _speech.stop();
      //     _checkAnswer(animals[currentIndex].name);
      //   },
      //   child: const Text('Check Answer'),
      // ),
    );
  }

  Widget _buildAnimalCard(AnimalItem animal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(animal.imagePath, height: 200, width: 170),
      ],
    );
  }

  // void _nextAnimal() {
  //   setState(() {
  //     currentIndex = (currentIndex + 1) % animals.length;
  //     Text(
  //       spokenWord.isEmpty ? spokenWord : spokenWord,
  //       style: TextStyle(
  //         fontSize: 20,
  //         color: spokenWord.toLowerCase() == animals[currentIndex].name.toLowerCase() && spokenWord.isNotEmpty ? Colors.blue : Colors.black,
  //       ),
  //     );
  //     // spokenWord = '';
  //   });
  // }

  // void _checkAnswer(String guessedAnimal) {
  //   String correctAnimalName = animals[currentIndex].name.toLowerCase();
  //   String spokenWordLower = guessedAnimal.toLowerCase();
  //
  //   // Remove any leading or trailing whitespace
  //   guessedAnimal = guessedAnimal.trim();
  //   spokenWordLower = spokenWordLower.trim();
  //
  //   if (spokenWordLower == correctAnimalName || _isSimilar(spokenWordLower, correctAnimalName)) {
  //     setState(() {
  //       score++;
        // Text(
        //   spokenWord,
        //   style: TextStyle(
        //     fontSize: 20,
        //     color: spokenWord.toLowerCase() == animals[currentIndex].name.toLowerCase() && spokenWord.isNotEmpty ? Colors.blue : Colors.black,
        //   ),
        // );
        // _nextAnimal();
  //     });
  //   }
  // }

  void _checkAnswer(String guessedAnimal) {
    String correctAnimalName = animals[0].name.toLowerCase();
    String spokenWordLower = guessedAnimal.toLowerCase();

    // Remove any leading or trailing whitespace
    guessedAnimal = guessedAnimal.trim();
    spokenWordLower = spokenWordLower.trim();

    if (spokenWordLower == correctAnimalName) {
      setState(() {
        score++;
      });
      _showSnackbar('Correct answer!', true);
    } else {
      _showSnackbar('Incorrect answer!', false);
    }
  }

  void _showSnackbar(String message, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 800), // Adjust the duration as needed
        backgroundColor: isCorrect ? Colors.green : Colors.red, // Change color based on correctness
      ),
    );
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
          _checkAnswer(result.recognizedWords); // Move this line to _checkAnswer method
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


