import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/game1/guess/guessinggame9.dart';
import 'package:game/category1/home1.dart';

class GuessingGame8 extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  GuessingGame8({Key? key, required this.username, required this.email, required this.age}) : super(key: key);
  @override
  _GuessingGame8State createState() => _GuessingGame8State();
}

class _GuessingGame8State extends State<GuessingGame8> {
  int score = 0;
  List<Animal> animals = [
    Animal(name: 'deer', imagePath: 'assets/animals/deer.png', points: 1),
    Animal(name: 'Cheetah', imagePath: 'assets/animals/cheetah.png', points: 1),
  ];

  List<List<Animal>> allAnimalCategories = [];
  bool showNextLevelButton = false;

  @override
  void initState() {
    super.initState();
    allAnimalCategories.add(animals);
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Row(
          children: [
            Text("Level 8"),
            SizedBox(width: 110,),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(
                    username: widget.username, email: widget.email, age: widget.age)));
              },
              icon: Icon(Icons.home), // Home button on the right side
            ),
            SizedBox(width: 5),
            Text("Score: $score"),
          ],
        ),
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
                itemCount: animals.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimalCard(
                    animal: animals[index],
                    onMatched: () {
                      setState(() {
                        animals[index].matched = true;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: _submitGuesses,
                child: const Text('Submit'),
              ),
              SizedBox(height: 10,),
              if (showNextLevelButton)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GuessingGame9(
                        username: widget.username, email: widget.email, age: widget.age,
                      )),
                    );
                  },
                  child: const Text("Next Level"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitGuesses() {
    bool allMatched = true;
    bool anyCorrectGuess = false; // To track if any correct guess is made

    // Loop through animals to check each guess
    for (var animal in animals) {
      if (animal.matched == false && animal.name.toLowerCase() == animal.typedName.trim().toLowerCase()) {
        animal.matched = true;
        anyCorrectGuess = true; // At least one correct guess is made
        if(score==10 || score==11){
          score = score + 1; // Increment score by 1 for each correct guess
          _updateScoreInFirebase();
        }
      }
      // Check if any animal is not matched
      if (!animal.matched) {
        allMatched = false;
      }
    }

    // Show snackbar based on matching results
    if (anyCorrectGuess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 700),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect!'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 700),
        ),
      );
    }

    // Update state based on matching results
    setState(() {
      if (allMatched) {
        showNextLevelButton = true; // Show Next Level button if all animals are matched
      }
    });
  }

  void _updateScoreInFirebase() async {
    // Only update score if level is completed
    if (score == 12) {
      await Firebase.initializeApp();
      final DocumentReference userDocRef = FirebaseFirestore.instance
          .collection(widget.username)
          .doc('guessing');

      // Create a new document or update the existing one
      await userDocRef.set({
        'animal': {'score': score}, // Nested data for animal category and score
      }, SetOptions(merge: true)); // Merge to avoid overwriting other data
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('guessing');

    final DocumentSnapshot snapshot = await userDocRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('animal')) {
        setState(() {
          score = data['animal']['score'];
        });
      }
    }
  }
}

class Animal {
  final String name;
  final String imagePath;
  final int? points;
  String typedName = ''; // Store the typed name for each animal
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            widget.animal.matched ? widget.animal.imagePath : widget.animal.imagePath,
            height: 105,
            width: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            enabled: !widget.animal.matched, // Disable TextField if animal is matched
            textAlign: TextAlign.center,
            controller: textEditingController,
            textCapitalization: TextCapitalization.characters, // Convert input to uppercase
            onChanged: (value) {
              setState(() {
                widget.animal.typedName = value.toUpperCase(); // Store the typed name for each animal
              });
            },
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            decoration: const InputDecoration(
              hintText: 'Type the animal name',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
