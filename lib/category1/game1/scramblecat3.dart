import 'package:flutter/material.dart';

class Scramblecat3 extends StatefulWidget {
  const Scramblecat3({Key? key}) : super(key: key);

  @override
  _Scramblecat3State createState() => _Scramblecat3State();
}

class _Scramblecat3State extends State<Scramblecat3> {
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
        title: const Text('Scramble'),
        backgroundColor: Colors.blue.shade400,
        actions: [
          IconButton(
            onPressed: _showTotalPointsDialog,
            icon: const Icon(Icons.star),
          ),
          IconButton(onPressed: (){
            _showFoundWordsDialog(context);
          }, icon: Icon(Icons.abc_rounded)),
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
    }
  }

  bool _isValidWord(String word) {
    List<String> validWords = [
      'CAT', 'DOG', 'RABBIT', 'MOUSE', 'HORSE', 'COW', 'SHEEP', 'MONKEY', 'ELEPHANT', 'TIGER', 'LION',
      'BEAR', 'DEER', 'FOX', 'WOLF', 'PIG', 'GOAT', 'GIRAFFE', 'KANGAROO', 'KOALA', 'PANDA', 'SLOTH',
      'ZEBRA', 'OTTER', 'HIPPO', 'RHINO', 'GORILLA', 'CROCODILE', 'SQUIRREL', 'ALLIGATOR', 'RACCOON',
      'HEDGEHOG', 'LEMUR', 'MEERKAT', 'CHIMPANZEE', 'POLAR BEAR', 'JAGUAR', 'LEOPARD', 'PANTHER',
      'MOOSE', 'BUFFALO', 'CAMEL', 'MULE', 'DONKEY', 'LLAMA', 'ANTELOPE', 'ARMADILLO', 'BISON', 'ECHIDNA',
      'FERRET', 'KOALA', 'PANGOLIN', 'PLATYPUS', 'PORCUPINE', 'TAPIR', 'WALRUS', 'WOMBAT', 'YAK'
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
}
