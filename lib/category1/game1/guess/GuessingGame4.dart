import 'package:flutter/material.dart';
import 'package:game/category1/game1/guess/GuessingGame5.dart';
import 'package:game/category1/game1/guess/levelsection.dart';

class GuessingGame3 extends StatefulWidget {
  const GuessingGame3({Key? key}) : super(key: key);

  @override
  _GuessingGame3State createState() => _GuessingGame3State();
}

class _GuessingGame3State extends State<GuessingGame3> {
  int score = 0;
  int totalPoints = 0;



  List<Animal> fruits = [
    Animal(name: 'Apple', imagePath: 'assets/images/apple.png', points: 1),
    Animal(name: 'Orange', imagePath: 'assets/images/orange.png', points: 1),
    Animal(name: 'Banana', imagePath: 'assets/images/banana.png', points: 1),
    //  Animal(name: 'Grapes', imagePath: 'assets/images/grapes.png', points: 1),
  ];


  List<Animal> shuffledAnimals = [];

  List<List<Animal>> allAnimalCategories = [];

  int currentCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    allAnimalCategories.add(fruits);
    shuffledAnimals = List.from(allAnimalCategories[currentCategoryIndex])..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 4'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _shuffleAnimals,
          ),
          // IconButton(
          //   icon: const Icon(Icons.calculate),
          //   onPressed: () {
          //     _showTotalPoints();
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: shuffledAnimals.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimalCard(
                    animal: shuffledAnimals[index],
                    onMatched: () {
                      setState(() {
                        score += shuffledAnimals[index].points!;
                        totalPoints += shuffledAnimals[index].points!;
                        shuffledAnimals[index].matched = true;

                        // Check if all animals are matched
                        if (shuffledAnimals.every((animal) => animal.matched)) {
                          _showGameCompletedDialog();
                        }
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 50,),
              Text('Score: $score', style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }

  void _shuffleAnimals() {
    setState(() {
      // Increment the category index, and loop back to 0 if it exceeds the length
      currentCategoryIndex = (currentCategoryIndex + 1) % allAnimalCategories.length;
      // Shuffle the animals of the current category
      shuffledAnimals = List.from(allAnimalCategories[currentCategoryIndex])..shuffle();
      // Reset the score
      score = 0;
    });
  }

  void _showGameCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        totalPoints += score;
        return AlertDialog(
          title: const Text('Level 4 Completed'),
          //content: Text('Congratulations! You completed the matching game. Your total score: $totalPoints'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelSelection()));
              },
              child: const Text('OK'),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessingGame5()));
            }, child: Text('Next level'))
          ],
        );
      },
    );
  }

  void _showTotalPoints() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Points'),
          content: Text("Your total points: $totalPoints"),
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
}

class Animal {
  final String name;
  final String imagePath;
  final int? points;
  bool matched;

  Animal({
    required this.name,
    required this.imagePath,
    this.points,
    this.matched = false,
  });
}

class AnimalCard extends StatefulWidget {
  final Animal animal;
  final Function() onMatched;

  AnimalCard({Key? key, required this.animal, required this.onMatched}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  TextEditingController textEditingController = TextEditingController();
  String typedName = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.animal.matched) {
          _showAnimalNameDialog(context);
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.animal.matched ? widget.animal.imagePath : widget.animal.imagePath,
                height: 100,
                width: 80,
              ),
            ),
            if (typedName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$typedName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAnimalNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(26.0),
            child: const Text('Guess the animal?'),
          ),
          content: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                    typedName = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Type the animal name',
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  String enteredName = typedName.trim();
                  if (enteredName.isNotEmpty &&
                      enteredName.toLowerCase() == widget.animal.name.toLowerCase()) {
                    Navigator.pop(context);
                    widget.onMatched();
                  } else {
                    // Show incorrect guess message
                    _showIncorrectGuessDialog(context);
                  }
                },
                child: const Text('Match'),
              ),
            ],
          ),
        );
      },
    );
  }


  void _showIncorrectGuessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong Guess'),
          content: const Text('Incorrect guess! Please try again.'),
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
}