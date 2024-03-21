import 'package:flutter/material.dart';
import 'dart:math';

class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  final List<String> words = ['BOOK', 'COMPUTER', 'CAR', 'LEAVES', 'HOUSE'];
  List<List<String>> grid = [];
  List<bool> foundWords = [];
  List<bool> selectedLetters = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateGrid();
    _findWords();
    selectedLetters = List<bool>.filled(grid.length * grid.length, false);
  }

  void _generateGrid() {
    final List<String> letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    grid = List.generate(8, (_) => List.generate(8, (_) => letters[Random().nextInt(letters.length)])); // Use random letters
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final rng = Random();
      final row = rng.nextInt(8);
      final col = rng.nextInt(8);
      final isHorizontal = rng.nextBool();

      if (isHorizontal) {
        if (col + word.length < 8) {
          for (int j = 0; j < word.length; j++) {
            grid[row][col + j] = word[j];
          }
        }
      } else {
        if (row + word.length < 8) {
          for (int j = 0; j < word.length; j++) {
            grid[row + j][col] = word[j];
          }
        }
      }
    }
  }

  void _findWords() {
    foundWords = List.generate(words.length, (_) => false);
  }

  void _checkWord(int wordIndex) {
    setState(() {
      if (!foundWords[wordIndex]) {
        score++;
        foundWords[wordIndex] = true;
      }
    });
  }

  void _submit() {
    setState(() {
      bool wordFound = false;
      for (int i = 0; i < words.length; i++) {
        String word = words[i];
        bool found = true;
        for (int j = 0; j < word.length; j++) {
          int index = grid.expand((row) => row).toList().indexOf(word[j]);
          if (index == -1 || !selectedLetters[index]) {
            found = false;
            break;
          }
        }
        if (found && !foundWords[i]) {
          _checkWord(i);
          wordFound = true;
          break;
        }
      }
      if (wordFound) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Score: $score'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No new words found.'),
          ),
        );
      }
      selectedLetters = List<bool>.filled(grid.length * grid.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Search'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("Find the words inside grid by tapping on the letters",style: TextStyle(
                fontSize: 22
            ),),
            SizedBox(height: 60,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8, // Adjust grid size here
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: grid.length * grid.length,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ grid.length;
                  int col = index % grid.length;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLetters[index] = !selectedLetters[index];
                      });
                    },
                    child: Container(
                      color: selectedLetters[index] ? Colors.green : Colors.blue[100],
                      child: Center(
                        child: Text(
                          grid[row][col],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: Text('Submit',style: TextStyle(
                    fontSize: 20
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}