import 'package:flutter/material.dart';

class Match2 extends StatefulWidget {
  const Match2({Key? key}) : super(key: key);

  @override
  _Match2State createState() => _Match2State();
}

class _Match2State extends State<Match2> {
  List<List<Animal>> animalSets = [
    [

      Animal(name: 'dog', imagePath: 'assets/animals/dog.png'),
      Animal(name: 'fox', imagePath: 'assets/animals/fox.png'),
      Animal(name: 'zebra', imagePath: 'assets/animals/zebra.png'),
      Animal(name: "lion", imagePath: 'assets/animals/lion.png'),

    ],
    [
      Animal(name: 'dog', imagePath: 'assets/animals/dog.png'),
      Animal(name: 'fox', imagePath: 'assets/animals/fox.png'),
      Animal(name: 'zebra', imagePath: 'assets/animals/zebra.png'),
      Animal(name: "lion", imagePath: 'assets/animals/lion.png'),
    ],
    // Add more sets as needed
  ];

  int currentSetIndex = 0;
  late List<Animal> currentAnimals;
  Map<String, GlobalKey> imageKeys = {};
  Map<String, GlobalKey> nameKeys = {};
  Map<String, bool> answerStatus = {};
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    currentAnimals = animalSets[currentSetIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _shuffleNames,
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              _showTotalPoints(totalPoints);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildAnimalList(),
                  ),
                  Expanded(
                    child: buildAnimalNamesList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(68.0),
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswers();
                },
                child: const Text('Check Answers'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimalList() {
    return ListView(
      children: currentAnimals.map((animal) {
        imageKeys[animal.name] = GlobalKey();
        bool isDropped = answerStatus[animal.name] ?? false;

        return DragTarget<String>(
          onWillAccept: (data) => true,
          onAccept: (data) {
            setState(() {
              answerStatus[animal.name] = data == animal.name;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return isDropped
                ? Container()
                : Draggable(
              data: animal.name,
              feedback: Container(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    animal.imagePath,
                    height: 80,
                    width: 100,
                  ),
                ),
              ),
              childWhenDragging: Container(),
              child: Container(
                key: imageKeys[animal.name],
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    animal.imagePath,
                    height: 100,
                    width: 120,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildAnimalNamesList() {
    List<String> shuffledNames =
    currentAnimals.map((animal) => animal.name).toList()..shuffle();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: shuffledNames.map((name) {
          nameKeys[name] = GlobalKey();
          bool isCorrect = answerStatus[name] ?? false;
          Color color = isCorrect ? Colors.green : Colors.transparent;

          return DragTarget<String>(
            onWillAccept: (data) => true,
            onAccept: (data) {
              setState(() {
                answerStatus[name] = data == name;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                key: nameKeys[name],
                padding: const EdgeInsets.all(8.0),
                color: color,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 29),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void _checkAnswers() {
    int correctAnswers =
        answerStatus.values.where((element) => element).length;
    int pointsEarned = (correctAnswers / currentAnimals.length * 4).toInt();
    totalPoints += pointsEarned;
    _showGameCompletedDialog(
        "Congratulations! You earned $pointsEarned points in this game.");
  }

  void _showGameCompletedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Completed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showTotalPoints(int points) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Points'),
          content: Text("Your total points: $points"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _shuffleNames() {
    setState(() {
      currentSetIndex = (currentSetIndex + 1) % animalSets.length;
      currentAnimals = animalSets[currentSetIndex];
      answerStatus.clear();
    });
  }
}

class Animal {
  final String name;
  final String imagePath;

  Animal({required this.name, required this.imagePath});
}