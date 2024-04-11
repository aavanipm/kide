import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Search8 extends StatefulWidget {
  @override
  _Search8State createState() => _Search8State();
}

class _Search8State extends State<Search8> {
  final List<String> wordsToFind = ['TIGER', 'CHEETAH', 'COW', 'GOAT', 'SHEEP'];
  late List<List<String>> grid;
  int score = 0;
  String currentWord = '';
  Set<int> selectedIndices = {};
  List<String> foundWords = []; // Stores found words
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      initialized = true;
    });
    _getStoredScore();
    grid = generateGrid(wordsToFind);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 8'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text("Score: $score",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
          ),
        ],
      ),
      body: initialized
          ? Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Find these words by tapping the letters orderly",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10,),
            Text('${wordsToFind.join(', ')}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.pinkAccent)
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                itemCount: grid.length * grid.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid.length,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ grid.length;
                  int col = index % grid.length;
                  return GestureDetector(
                    onTap: () {
                      _selectGridCell(row, col);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: selectedIndices.contains(index) ? Colors.blue : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          grid[row][col],
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('$currentWord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitWord();
                  },
                  child: Text('Submit'),
                ),
                SizedBox(width: 30,),
                ElevatedButton(
                  onPressed: () {
                    _clearWord();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 70,),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _selectGridCell(int row, int col) {
    setState(() {
      int index = row * grid.length + col;
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
        currentWord = currentWord.replaceAll(grid[row][col], '');
      } else {
        selectedIndices.add(index);
        currentWord += grid[row][col];
      }
    });
  }

  void _submitWord() {
    if (wordsToFind.contains(currentWord)) {
      if (!foundWords.contains(currentWord)) {
        setState(() {
          score++;
          foundWords.add(currentWord);
          _updateScoreInFirebase();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(currentWord+" already founded"),
              duration: Duration(milliseconds: 600),
            )
        );
      }
      // wordsToFind.remove(currentWord);
      currentWord = '';
      selectedIndices.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(currentWord + "not in the list"),
            duration: Duration(milliseconds: 600),
          )
      );
    }
  }

  void _clearWord(){
    setState(() {
      currentWord = '';
      selectedIndices.clear();
    });
  }

  void _updateScoreInFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('games').doc(user.uid).set({
        'gameData': {
          'wordsearch': {'score': score, 'foundWords': foundWords},
        },
      }, SetOptions(merge: true));
    }
  }

  void _getStoredScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('wordsearch')) {
            setState(() {
              score = gameScores['wordsearch']['score'] ?? 0;
              foundWords = List<String>.from(gameScores['wordsearch']['foundWords'] ?? []);
            });
          }
        }
      }
    }
  }
}

List<List<String>> generateGrid(List<String> wordsToFind) {
  final List<String> letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  final Random random = Random();
  final List<List<String>> grid = [];

  // Initialize an empty grid
  for (int i = 0; i < 8; i++) {
    final List<String> row = [];
    for (int j = 0; j < 8; j++) {
      row.add('');
    }
    grid.add(row);
  }

  // Place words horizontally or vertically without overlap
  for (final word in wordsToFind) {
    bool placed = false;
    while (!placed) {
      final bool horizontal = random.nextBool();
      int row, col;
      if (horizontal) {
        // Place horizontally
        row = random.nextInt(8);
        col = random.nextInt(8 - word.length + 1);
        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row][col + i] != '' && grid[row][col + i] != word[i]) {
            canPlace = false;
            break;
          }
        }
        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row][col + i] = word[i];
          }
          placed = true;
        }
      } else {
        // Place vertically
        row = random.nextInt(8 - word.length + 1);
        col = random.nextInt(8);
        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row + i][col] != '' && grid[row + i][col] != word[i]) {
            canPlace = false;
            break;
          }
        }
        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row + i][col] = word[i];
          }
          placed = true;
        }
      }
    }
  }

  // Fill empty spaces with random letters
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (grid[i][j] == '') {
        final randomIndex = random.nextInt(letters.length);
        grid[i][j] = letters[randomIndex];
      }
    }
  }
  return grid;
}


