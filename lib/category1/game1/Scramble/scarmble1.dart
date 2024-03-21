//scramble old
// import 'package:flutter/material.dart';
//
// class Scramble1 extends StatefulWidget {
//   const Scramble1({super.key});
//
//   @override
//   _Scramble1State createState() => _Scramble1State();
// }
//
// class _Scramble1State extends State<Scramble1> {
//   late List<String> letters;
//   String currentWord = '';
//   List<String> playedWords = [];
//   List<String> foundWords = []; // Maintain a list of found words
//   int totalPoints = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//   }
//
//   void _initializeGame() {
//     letters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
//     currentWord = '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       // onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Scramble Animals'),
//           backgroundColor: Colors.blue.shade100,
//           actions: [
//             IconButton(onPressed: (){
//               _showTotalPointsDialog(context);
//             }, icon: const Icon(Icons.star)),
//
//             IconButton(onPressed: (){
//               _showFoundWordsDialog(context);
//             }, icon: Icon(Icons.abc_rounded)),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//
//               const SizedBox(height: 20,),
//               const Text("Build words from letters",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
//               const SizedBox(height: 20,),
//
//               _buildDraggableGrid(),
//
//               const SizedBox(height: 30,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 224),
//                 child: _buildRefreshButton(),
//               ),
//               const SizedBox(height: 10,),
//
//               _buildDraggableSpace(),
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                    // Text('Played Words: ${playedWords.join(', ')}'),
//                     Text('Points: $totalPoints'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDraggableGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemCount: letters.length,
//       itemBuilder: (context, index) {
//         String tile = letters[index];
//         return _buildTileDraggable(tile);
//       },
//     );
//   }
//
//   Widget _buildDraggableSpace() {
//     return DragTarget<String>(
//       builder: (context, candidateData, rejectedData) {
//         return Container(
//           margin: const EdgeInsets.all(8.0),
//           padding: const EdgeInsets.all(18.0),
//           color: Colors.yellow.shade200,
//           child: Center(
//             child: Text(currentWord, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//           ),
//         );
//       },
//       onWillAcceptWithDetails: (data) {
//         return true;
//       },
//       onAccept: (data) {
//         _handleLetterDrop(data);
//       },
//       onLeave: (data) {
//         _clearCurrentWord();
//       },
//     );
//   }
//
//   void _clearCurrentWord() {
//     setState(() {
//       currentWord = '';
//     });
//   }
//
//   Widget _buildRefreshButton() {
//     return ElevatedButton(
//       onPressed: () {
//         _clearCurrentWord();
//       },
//       child: const Text('Refresh'),
//     );
//   }
//
//
//   Widget _buildTileDraggable(String tile) {
//     return Draggable<String>(
//       data: tile,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(30) ,
//         child: Container(
//           // margin: const EdgeInsets.all(8.0),
//           // padding: const EdgeInsets.all(8.0),
//           color: Colors.green.shade100,
//
//           child: Center(
//             child: Text(tile, style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//
//             ),),
//           ),
//         ),
//       ),
//       feedback: Container(
//         margin: const EdgeInsets.all(8.0),
//         padding: const EdgeInsets.all(8.0),
//         color: Colors.blue.withOpacity(0.7),
//         child: Text(tile),
//       ),
//       childWhenDragging: Container(),
//     );
//   }
//
//   void _handleLetterDrop(String letter) {
//     setState(() {
//       currentWord += letter;
//     });
//     _checkWord();
//   }
//
//   void _checkWord() {
//     if (currentWord.isNotEmpty && _isValidWord(currentWord)) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Congratulations! 1 point for $currentWord'),
//       ));
//
//       setState(() {
//         playedWords.add(currentWord);
//         foundWords.add(currentWord); // Add the found word to the list
//
//         totalPoints += 1; // 1 point for each valid word
//         _initializeGame(); // Start a new round
//       });
//     }
//   }
//
//   bool _isValidWord(String word) {
//     List<String> validWords = [
//       'CAT', 'DOG', 'RABBIT', 'MOUSE', 'HORSE', 'COW', 'SHEEP', 'MONKEY', 'ELEPHANT', 'TIGER', 'LION',
//       'BEAR', 'DEER', 'FOX', 'WOLF', 'PIG', 'GOAT', 'GIRAFFE', 'KANGAROO', 'KOALA', 'PANDA', 'SLOTH',
//       'ZEBRA', 'OTTER', 'HIPPO', 'RHINO', 'GORILLA', 'CROCODILE', 'SQUIRREL', 'ALLIGATOR', 'RACCOON',
//       'HEDGEHOG', 'LEMUR', 'MEERKAT', 'CHIMPANZEE', 'POLAR BEAR', 'JAGUAR', 'LEOPARD', 'PANTHER',
//       'MOOSE', 'BUFFALO', 'CAMEL', 'MULE', 'DONKEY', 'LLAMA', 'ANTELOPE', 'ARMADILLO', 'BISON', 'ECHIDNA',
//       'FERRET', 'KOALA', 'PANGOLIN', 'PLATYPUS', 'PORCUPINE', 'TAPIR', 'WALRUS', 'WOMBAT', 'YAK'
//     ];
//     return validWords.contains(word.toUpperCase());
//   }
//
//
//   void _showTotalPointsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Total Points'),
//         content: Text('You scored a total of $totalPoints points.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>const Scramble1()));
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     ).then((value) {
//       Navigator.of(context).pop();
//     });
//   }
//
//   void _showFoundWordsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Found Words'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: foundWords.map((word) => Text(word)).toList(), // Display each found word
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';

class Scramble1 extends StatefulWidget {
  const Scramble1({Key? key}) : super(key: key);

  @override
  _Scramble1State createState() => _Scramble1State();
}

class _Scramble1State extends State<Scramble1> {
  late List<String> letters;
  String currentWord = '';
  List<String> playedWords = [];
  List<String> foundWords = [];
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
          title: const Text('Scramble Animals'),
          backgroundColor: Colors.blue.shade100,
          actions: [
            IconButton(
              onPressed: () {
                _showTotalPointsDialog(context);
              },
              icon: const Icon(Icons.star),
            ),
            IconButton(
              onPressed: () {
                _showFoundWordsDialog(context);
              },
              icon: Icon(Icons.abc_rounded),
            ),
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
                      Text('Points: $totalPoints'),
                    ],
                  ),
                ),
              ],
            ),
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
        _refreshGame();
      },
      child: const Text('Refresh'),
    );
  }

  Widget _buildTileDraggable(String tile) {
    return Draggable<String>(
      data: tile,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.green.shade100,
          child: Center(
            child: Text(tile, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
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
    _checkWord();
  }

  void _checkWord() {
    if (currentWord.isNotEmpty && _isValidWord(currentWord) && !playedWords.contains(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Congratulations! 1 point for $currentWord'),
      ));

      setState(() {
        playedWords.add(currentWord);
        foundWords.add(currentWord); // Add the found word to the list

        totalPoints += 1; // 1 point for each valid word
        _initializeGame(); // Start a new round
      });
    } else if (playedWords.contains(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$currentWord was already typed.'),
      ));
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

  void _showTotalPointsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Total Points'),
        content: Text('You scored a total of $totalPoints points.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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