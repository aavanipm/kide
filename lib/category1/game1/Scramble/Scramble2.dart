import 'package:flutter/material.dart';

class Scramble2 extends StatefulWidget {
  const Scramble2({Key? key}) : super(key: key);

  @override
  _Scramble2State createState() => _Scramble2State();
}

class _Scramble2State extends State<Scramble2> {
  late List<String> letters;
  String currentWord = '';
  Set<String> playedWords = {};
  List<String> foundWords = []; // Maintain a list of found words

  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    letters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
    currentWord = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scramble Birds'),
        backgroundColor: Colors.blue.shade400,
        actions: [
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
                    Text('Points: $totalPoints', style: const TextStyle(fontSize: 18)),
                    SizedBox(width: 30,),
                    _buildRefreshButton(),
                    ElevatedButton(
                      onPressed: _submitWord,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
              // Column(
              //   children: [
              //     Text('${playedWords.join(', ')}', style: const TextStyle(fontSize: 10)),
              //   ],
              // ),
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
        _clearCurrentWord();
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

  void _submitWord() {
    if (currentWord.isNotEmpty && !_isWordAlreadyPlayed(currentWord) && _isValidWord(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('1 point awarded!'),
        ),
      );
      setState(() {
        playedWords.add(currentWord.toUpperCase());
        foundWords.add(currentWord); // Add the found word to the list

        totalPoints += 1;
        _clearCurrentWord();
      });
    } else if (playedWords.contains(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$currentWord was already typed.'),
      ));
    }
  }

  bool _isValidWord(String word) {
    List<String> validWords = [
      'CROW', 'BLUE JAY', 'CARDINAL', 'ROBIN', 'STARLING', 'CANARY', 'BLACKBIRD', 'GOLDFINCH',
      'SWALLOW', 'PIGEON', 'SWIFT', 'THRUSH', 'WARBLER', 'WREN', 'JAY', 'WOODCOCK', 'NIGHTINGALE',
      'FINCH', 'TANAGER', 'PARAKEET', 'EAGLE', 'OWL', 'PARROT', 'OSTRICH', 'PEACOCK', 'HAWK',
      'FALCON', 'PENGUIN', 'SWAN', 'FLAMINGO', 'SPARROW', 'HUMMINGBIRD', 'PELICAN', 'WOODPECKER',
      'CRANE', 'SEAGULL', 'TURKEY', 'DUCK', 'GOOSE', 'HEN',
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
        content: Text('You scored a total of $totalPoints points.'),
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
              setState(() {
                playedWords.clear();
                foundWords.clear();
                totalPoints = 0;
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
}
//
// 'CROW', 'PIGEON', 'TURKEY', 'DUCK', 'HEN', 'EAGLE', 'OWL', 'PARROT', 'OSTRICH', 'PEACOCK',
//   'ROBIN', 'CANARY', 'FLAMINGO', 'SPARROW', 'HUMMINGBIRD', 'WOODPECKER', 'NIGHTINGALE',
//   'SEAGULL', 'FALCON', 'PENGUIN', 'SWAN',
// 'SWALLOW', 'WREN', 'JAY', 'WOODCOCK',
// 'FINCH', 'TANAGER', 'PARAKEET',  'HAWK',
// 'CRANE',  'GOOSE',