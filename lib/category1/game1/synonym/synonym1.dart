import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/synonym/synonym2.dart';
import 'package:game/category1/game1/synonym/Synonymlevels.dart';

class Synonym1 extends StatefulWidget {
  const Synonym1({Key? key}) : super(key: key);

  @override
  _Synonym1State createState() => _Synonym1State();
}

class _Synonym1State extends State<Synonym1> {
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
    _getStoredScore();
  }

  void _nextWord() {
    setState(() {
      displayedOptions.clear();
      currentWord = 'happy';
      displayedOptions.addAll(wordSynonyms[currentWord]!);
      displayedOptions.addAll(wordNotSimilar[currentWord]!);
      displayedOptions.shuffle();
      correctSynonyms = wordSynonyms[currentWord]!;
      showCorrectSynonyms = false;
    });
  }

  void _checkAnswer(String selectedWord) {
    setState(() {
      if (wordSynonyms[currentWord]!.contains(selectedWord)) {
        score++;
        displayedOptions.remove(selectedWord);
        correctSynonyms.remove(selectedWord);
        showCorrectSynonyms = true;
        _updateScoreInFirebase();
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

  void _updateScoreInFirebase() async {
    // Only update score if level 1 is completed
    if (score==14) {
      await Firebase.initializeApp();
      final DocumentReference documentReference =
      FirebaseFirestore.instance.collection('synonym').doc('userScore');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection('synonym').doc('userScore');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
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