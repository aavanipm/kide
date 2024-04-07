import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/Scramble/Scramblelevels.dart';

class Scramble6 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Scramble6(
      {Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}
      ) : super(key: key);

  @override
  _Scramble6State createState() => _Scramble6State();
}

class _Scramble6State extends State<Scramble6> {
  late List<String> letters;
  String currentWord = '';
  Set<String> playedWords = {};
  List<String> foundWords = []; // Maintain a list of found words
  int score = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _getStoredScore();
  }

  void _initializeGame() {
    letters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
    currentWord = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scramble Numbers'),
        backgroundColor: Colors.blue.shade400,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ScrambleLevel(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory)));
            },
            icon: Icon(Icons.home), // Home button on the right side
          ),
          IconButton(
            onPressed: _showTotalPointsDialog,
            icon: const Icon(Icons.star),
          ),
          IconButton(onPressed: (){
            _showFoundWordsDialog(context);
          }, icon: Icon(Icons.abc_rounded)),
          IconButton(
            onPressed: () {
              _refreshGame();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Build words from letters",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildDraggableGrid(),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              _buildDraggableSpace(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Points: $score', style: const TextStyle(fontSize: 18)),
                    SizedBox(width: 30,),
                    _buildRefreshButton(),
                    ElevatedButton(
                      onPressed: _submitWord,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableGrid() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        String tile = letters[index];
        return _buildTileDraggable(tile);
      },
    );
  }

  Widget _buildDraggableSpace() {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(18.0),
          color: Colors.yellow.shade200,
          child: Center(
            child: Text(currentWord, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
        );
      },
      onWillAcceptWithDetails: (data) {
        return true;
      },
      onAccept: (data) {
        _handleLetterDrop(data);
      },
      onLeave: (data) {
        _clearCurrentWord();
      },
    );
  }

  void _clearCurrentWord() {
    setState(() {
      currentWord = '';
    });
  }

  Widget _buildRefreshButton() {
    return ElevatedButton(
      onPressed: () {
        if (currentWord.isNotEmpty) {
          setState(() {
            currentWord = currentWord.substring(0, currentWord.length - 1); // Remove the last letter
          });
        }
      },
      child: const Text('Clear'),
    );
  }

  Widget _buildTileDraggable(String tile) {
    return Draggable<String>(
      data: tile,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          // margin: const EdgeInsets.all(8.0),
          // padding: const EdgeInsets.all(8.0),
          color: Colors.green.shade100,
          child: Center
            (child: Text(tile, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ),
        ),
      ),
      feedback: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        color: Colors.blue.withOpacity(0.7),
        child: Text(tile),
      ),
      childWhenDragging: Container(),
    );
  }

  void _handleLetterDrop(String letter) {
    setState(() {
      currentWord += letter;
    });
  }

  bool _isValidWord(String word) {
    List<String> validWords = [
      'ZERO', 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX',
      'SEVEN', 'EIGHT', 'NINE', 'TEN',
      'ELEVEN', 'TWELVE', 'THIRTEEN', 'FOURTEEN', 'FIFTEEN',
      'SIXTEEN', 'SEVENTEEN', 'EIGHTEEN',
      'NINETEEN', 'TWENTY', 'THIRTY', 'FORTY', 'FIFTY',
      'SIXTY', 'SEVENTY', 'EIGHTY', 'NINETY', 'HUNDRED'
    ];
    return validWords.contains(word.toUpperCase());
  }

  bool _isWordAlreadyPlayed(String word) {
    return playedWords.contains(word.toUpperCase());
  }

  void _showTotalPointsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Total Points'),
        content: Text('You scored a total of $score points.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFoundWordsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Found Words'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: foundWords.map((word) => Text(word)).toList(), // Display each found word
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _refreshGame() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh Game'),
        content: Text('Are you sure you want to refresh the game? This will reset your score to zero.'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteScoreAndWordsFromDatabase();
              setState(() {
                playedWords.clear();
                foundWords.clear();
                score = 0;
                _initializeGame();
              });
              Navigator.pop(context);
            },
            child: const Text('Refresh'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _submitWord() {
    if(currentWord.isNotEmpty && _isValidWord(currentWord)) {
      if(_isWordAlreadyPlayed(currentWord)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$currentWord was already typed.'),
            duration: Duration(milliseconds: 700),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('1 point awarded!'),
          ),
        );
        setState(() {
          playedWords.add(currentWord.toUpperCase());
          foundWords.add(currentWord); // Add the found word to the list
          score += 1;
          _updateScoreAndPlayedWordsInFirebase(currentWord);
          _clearCurrentWord();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid word.'),
          duration: Duration(milliseconds: 700),
        ),
      );
    }
  }

  void _deleteScoreAndWordsFromDatabase() async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('scramble');
    await userDocRef.delete();
  }

  void _updateScoreAndPlayedWordsInFirebase(String newWord) async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('scramble');
    // Create a new document or update the existing one
    await userDocRef.set(
      {
        'number': {
          'score': score,
          'foundWords': FieldValue.arrayUnion([newWord]), // Add only new word
        },
      },
      SetOptions(merge: true), // Merge to avoid overwriting other data
    );
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('scramble');
    final DocumentSnapshot snapshot = await userDocRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data =
      snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('number')) {
        setState(() {
          score = data['number']['score'];
          foundWords = List<String>.from(data['number']['foundWords']);
          playedWords = Set<String>.from(data['number']['foundWords']); // Update playedWords
        });
      }
    }
  }
}