import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordUpHomePage extends StatefulWidget {
  const WordUpHomePage({Key? key}) : super(key: key);

  @override
  _WordUpHomePageState createState() => _WordUpHomePageState();
}

class _WordUpHomePageState extends State<WordUpHomePage> {
  List<String> vocabularyWords = [
    'Excited',
    'Enthusiastic',
    'Bored',
    'Confused',
    'Curious',
  ];

  List<String> definitions = [
    'Feeling or showing excitement',
    'Having or showing intense and eager enjoyment, interest, or approval',
    'Feeling weary and impatient because one is unoccupied or lacks interest in one\'s current activity',
    'Unable to think clearly; bewildered',
    'Eager to know or learn something',
  ];

  List<String> selectedWords = [];
  List<bool> wordMatched = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Learn vocabulary with words with their definitions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: vocabularyWords.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        vocabularyWords[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: wordMatched[index]
                          ? Text(
                        definitions[index],
                        style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                          : Text(
                        definitions[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (!wordMatched[index] &&
                              selectedWords.length < 2) {
                            selectedWords.add(vocabularyWords[index]);
                            if (selectedWords.length == 2) {
                              if (definitions.contains(selectedWords[0]) &&
                                  definitions.contains(selectedWords[1])) {
                                int index1 =
                                vocabularyWords.indexOf(selectedWords[0]);
                                int index2 =
                                vocabularyWords.indexOf(selectedWords[1]);
                                wordMatched[index1] = true;
                                wordMatched[index2] = true;
                              }
                              selectedWords.clear();
                            }
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}