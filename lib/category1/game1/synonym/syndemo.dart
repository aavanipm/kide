import 'package:flutter/material.dart';

class SynonymFinderScreen extends StatefulWidget {
  const SynonymFinderScreen({Key? key}) : super(key: key);

  @override
  _SynonymFinderScreenState createState() => _SynonymFinderScreenState();
}

class _SynonymFinderScreenState extends State<SynonymFinderScreen> {
  final Map<String, List<String>> wordSynonyms = {
    'happy': ['joyful', 'blissful', 'cheerful', 'content', 'delighted', 'ecstatic', 'elated', 'glad'],
  };

  final Map<String, List<String>> wordNotSimilar = {
    'happy': ['sad', 'angry', 'unhappy', 'fine', 'great', 'gloomy', 'tough'],
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
      currentWord = 'happy';
      displayedOptions.addAll(wordSynonyms[currentWord]!);
      displayedOptions.addAll(wordNotSimilar[currentWord]!);
      // displayedOptions.shuffle();
      correctSynonyms = wordSynonyms[currentWord]!;
      showCorrectSynonyms = false;
    });
  }

  void _checkAnswer(String selectedWord) {
    if (wordSynonyms[currentWord]!.contains(selectedWord)) {
      setState(() {
        score++;
        displayedOptions.remove(selectedWord);
        correctSynonyms.remove(selectedWord);
        showCorrectSynonyms = true;
      });
    }
    _nextWord();
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