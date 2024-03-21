import 'package:flutter/material.dart';
import 'package:game/category1/game1/synonym/synonym2.dart';
import 'package:game/category1/game1/synonym/Synonymlevels.dart';

class Synonym8 extends StatefulWidget {
  const Synonym8({Key? key}) : super(key: key);

  @override
  _Synonym8State createState() => _Synonym8State();
}

class _Synonym8State extends State<Synonym8> {
  final Map<String, List<String>> wordSynonyms = {
    'bad': ['Poor', 'Awful', 'Terrible', 'Horrible', 'Unpleasant', 'Negative', 'Inferior', 'Substandard'
    ],
  };

  final Map<String, List<String>> wordNotSimilar = {
    'bad': ['Excellent', 'Great', 'Wonderful', 'Fantastic', 'Superb', 'Fine', 'Terrific', 'Outstanding'
    ],
  };

  List<String> displayedOptions = [];
  String currentWord = '';
  List<String> correctSynonyms = [];
  bool showCorrectSynonyms = false;

  int score = 0;

  @override
  void initState() {
    super.initState();
    _nextWord();
  }

  void _nextWord() {
    setState(() {
      displayedOptions.clear();
      currentWord = 'bad';
      displayedOptions.addAll(wordSynonyms[currentWord]!);
      displayedOptions.addAll(wordNotSimilar[currentWord]!);
      displayedOptions.shuffle();
      correctSynonyms = wordSynonyms[currentWord]!;
      showCorrectSynonyms = false;
    });
  }

  //
  void _checkAnswer(String selectedWord) {
    setState(() {
      if (wordSynonyms[currentWord]!.contains(selectedWord)) {
        score++;
        displayedOptions.remove(selectedWord);
        correctSynonyms.remove(selectedWord);
        showCorrectSynonyms = true;
      }
      if (correctSynonyms.isEmpty) {
        _showAllCorrectMessage();
      } else {
        _nextWord();
      }
    });
  }

  void _showAllCorrectMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have found all the correct synonyms.'),
          actions: <Widget>[
            TextButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Synonymlevels()));
                }, child: Text("Home")),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextWord();
              },
              child: Text('Continue'),
            ),
            TextButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Synonym2()));
                }, child: Text("Next level")),
          ],
        );
      },
    );
  }

  void _showSynonymsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Synonyms for $currentWord'),
          content: Text(correctSynonyms.isNotEmpty ? correctSynonyms.join(', ') : 'No synonyms found.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synonym Finder'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            _showSynonymsDialog();
          }, icon: Icon(Icons.question_answer_outlined))

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Find the synonym for : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  currentWord,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Options:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: displayedOptions.map((word) {
                  return ElevatedButton(
                    onPressed: () => _checkAnswer(word),
                    child: Text(
                      word,
                      style: TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            if (showCorrectSynonyms) Text(
              correctSynonyms.isNotEmpty ? 'The synonyms are: ${correctSynonyms.join(", ")}' : '',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}