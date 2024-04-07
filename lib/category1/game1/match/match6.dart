import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/match/match.dart';
import 'package:game/category1/game1/match/match7.dart';
import 'package:game/category1/home1.dart';

class Match6 extends StatefulWidget {

  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Match6({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  _Match6State createState() => _Match6State();
}

class _Match6State extends State<Match6> {

  List<List<Animal>> animalSets = [
    [
      Animal(name: 'carrot', imagePath: 'assets/Vegetables/carrot.png'),
      Animal(name: 'monkey', imagePath: 'assets/animals/monkey.png'),
      Animal(name: 'banana', imagePath: 'assets/Fruits/banana.png'),
      Animal(name: 'fox', imagePath: 'assets/animals/fox.png'),
    ],
  ];

  int currentSetIndex = 0;
  late List<Animal> currentAnimals; // Original animal list
  late List<String> shuffledNames; // Shuffled list of animal names
  Map<String, GlobalKey> imageKeys = {};
  Map<String, GlobalKey> nameKeys = {};
  Map<String, bool> answerStatus = {};
  bool gameCompleted = false; // Add this variable to track game completion status
  int score = 0;

  @override
  void initState() {
    super.initState();
    currentAnimals = animalSets[currentSetIndex];
    shuffledNames = currentAnimals.map((animal) => animal.name).toList()..shuffle();
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 6'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>Match(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              ))
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              _showTotalPoints(score);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: currentAnimals.length,
                itemBuilder: (BuildContext context, int index) {
                  Animal animal = currentAnimals[index];
                  return Row(
                    children: [
                      Expanded(
                        child: buildAnimal(animal),
                      ),
                      Expanded(
                        child: buildAnimalName(shuffledNames[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(68.0),
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswers(); // Call _checkAnswers here
                },
                child: const Text('Submit'),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimal(Animal animal) {
    return DragTarget<String>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          answerStatus[animal.name] = data == animal.name;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Container(
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
            if (answerStatus[animal.name] == true)
              Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildAnimalName(String name) {
    return Draggable<String>(
      data: name,
      child: Container(
        key: nameKeys[name] ?? GlobalKey(),
        padding: const EdgeInsets.all(8.0),
        color: answerStatus[name] ?? false ? Colors.green : Colors.transparent,
        child: Text(
          name,
          style: const TextStyle(fontSize: 29),
        ),
      ),
      onDragCompleted: () {
        _checkAnswers(); // Call _checkAnswers when dragging is completed
      },
      childWhenDragging: Container(
        color: Colors.transparent, // Make invisible while dragging
      ),
      feedback: Text(
        name,
        style: TextStyle(
          fontSize: 29,
          color: Colors.grey.shade700, // Faded color while dragging
        ),
      ),
    );
  }

  void _checkAnswers() {
    int correctAnswers = 0;

    // Iterate through each animal in the current set
    for (Animal animal in currentAnimals) {
      String animalName = animal.name;
      String imageName = animal.imagePath.split('/').last.split('.').first;

      // Check if both the animal name and the image name are matched correctly
      if (answerStatus[animalName] == true && animalName == imageName) {
        correctAnswers++;
      }

      // Check if both the image name and the animal name are matched correctly
      if (answerStatus[imageName] == true && imageName == animalName) {
        correctAnswers++;
      }
    }

    // Calculate the total number of possible correct answers
    int totalCorrectAnswers = currentAnimals.length * 2;

    // If all answers are correct and the game is not completed yet, set score to 3 and mark game as completed
    if (correctAnswers == totalCorrectAnswers && !gameCompleted) {
      if (score==20){
        score = 24;
        _updateScoreInFirebase();
      }
      gameCompleted = true; // Set gameCompleted flag to true
    }

    // If the game is completed, show the game completion dialog
    if (gameCompleted){
      _showGameCompletedDialog("Congratulations! You completed this level.");
    }
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
                Navigator.pop(context); // Close the dialog
                _proceedToNextLevel(); // Proceed to the next level
              },
              child: const Text('Next Level'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _proceedToNextLevel() {
    if (widget.subscribedCategory == 'basic' ||
        widget.subscribedCategory == 'premium' ||
        widget.subscribedCategory == 'standard') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          Match7(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory,
          )));
    } else {
      _showSubscribeMessage(); // Shows subscribe message if conditions not met
    }
  }

  void _showSubscribeMessage() {
    String message = 'Subscribe to access more levels.';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscription Required'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory)));
                // Navigate to subscription page
              },
              child: Text('Subscribe'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
          content: Text("Your total points: $score"),
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
  void _updateScoreInFirebase() async {
    // Only update score if level 1 is completed
    if (score==24) {
      await Firebase.initializeApp();
      final DocumentReference documentReference =
      FirebaseFirestore.instance.collection(widget.username).doc('matching');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection(widget.username).doc('matching');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
  }
}

class Animal {
  String name;
  final String imagePath;
  Animal({required this.name, required this.imagePath});
}