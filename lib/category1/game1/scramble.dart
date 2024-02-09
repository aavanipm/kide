import 'package:flutter/material.dart';

class Scrambleone extends StatefulWidget {
  const Scrambleone({super.key});

  @override
  _ScrambleoneState createState() => _ScrambleoneState();
}

class _ScrambleoneState extends State<Scrambleone> {
  late List<String> letters;
  String currentWord = '';
  List<String> playedWords = [];
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
    return PopScope(
      canPop: true,
      // onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scramble'),
          backgroundColor: Colors.blue.shade400,
          actions: [
            IconButton(onPressed: (){
              _showTotalPointsDialog(context);
            }, icon: const Icon(Icons.star))

          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [

              const SizedBox(height: 20,),
              const Text("Build words from letters",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              _buildDraggableGrid(),

              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 224),
                child: _buildRefreshButton(),
              ),
              const SizedBox(height: 10,),

              _buildDraggableSpace(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Played Words: ${playedWords.join(', ')}'),
                    Text('Points: $totalPoints'),
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
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey,
          child: Center(
            child: Text(currentWord),
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
      child: const Text('Refresh'),
    );
  }


  Widget _buildTileDraggable(String tile) {
    return Draggable<String>(
      data: tile,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        color: Colors.blue,
        child: Text(tile),
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
    _checkWord();
  }

  void _checkWord() {
    if (currentWord.isNotEmpty && _isValidWord(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Congratulations! 1 point for $currentWord'),
      ));

      setState(() {
        playedWords.add(currentWord);
        totalPoints += 1; // 1 point for each valid word
        _initializeGame(); // Start a new round
      });
    }
  }

  bool _isValidWord(String word) {
    List<String> validWords = [
      'PEN', 'CAT', 'DOG', 'BAT', 'SIT', 'RAT', 'APPLE', 'BALL', 'ELEPHANT', 'GOAT', 'HEN', 'INK', 'JEEP', 'KITE', 'LIGHT',
      'MONKEY', 'NOSE', 'OWL', 'QUEEN', 'RAT', 'SAT', 'TEETH', 'UMBRELLA', 'VAN', 'WON', 'XYLEM', 'YES', 'ZEBRA', 'ANT', 'AUTO',
      'BEE', 'BED', 'BAD', 'BOY', 'BOOK', 'BAG', 'BENCH', 'CAR', 'COMB', 'CLOSE', 'CARD', 'CAP', 'CAMEL', 'COLD', 'HOT', 'LIE',
      'PENCIL', 'STICKER', 'TEACHER', 'CLASS', 'ROOM', 'ON', 'OLD', 'NEW', 'MEN', 'WOMEN', 'GIRL', 'CHILD', 'BIKE', 'FRUIT',
      'PHONE', 'GLASS', 'WATER', 'FOOD', 'RICE', 'FLOWER', 'TEA', 'COFFEE', 'LION', 'TIGER', 'WORM', 'SEA', 'RIVER', 'LAKE',
      'OCEAN', 'POND', 'STREAM', 'BEACH', 'SAND', 'SOIL', 'STAR', 'MOON', 'SUN', 'EARTH', 'HUMAN', 'ANIMAL', 'PLANT', 'POT',
      'FLAG', 'BOAT', 'SHIP', 'FISH', 'HOME', 'HOUSE', 'RESORT', 'ROCKET', 'ASTEROID', 'GALAXY', 'TRAIN', 'TRUCK', 'CYCLE', 'BUS',
      'ICE', 'ICECREAM', 'MOUNTAIN', 'TREE', 'ROOT', 'BIRD', 'SOUND', 'TIGER'
    ];
    return validWords.contains(word.toUpperCase());
  }


  void _showTotalPointsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Total Points'),
        content: Text('You scored a total of $totalPoints points.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Scrambleone()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ).then((value) {
      Navigator.of(context).pop();
    });
  }
}