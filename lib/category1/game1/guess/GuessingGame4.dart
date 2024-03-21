import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/game1/guess/GuessingGame4.dart';
import 'package:game/category1/game1/guess/GuessingGame5.dart';
import 'package:game/category1/home1.dart';

class GuessingGame4 extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  GuessingGame4({Key? key, required this.username, required this.email, required this.age}) : super(key: key);
  @override
  State<GuessingGame4> createState() => _GuessingGame4State();
}

class _GuessingGame4State extends State<GuessingGame4> {
  final Animal animal = Animal(name: "Parrot", imagePath: "assets/Birds/parrot.png");

  TextEditingController controller = TextEditingController();
  String? userAnswer;
  int score = 0;
  bool showNextLevelButton = false; // Track whether to show Next Level button

  @override
  void initState() {
    super.initState();
    userAnswer = "";
    _getStoredScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Row(
          children: [
            Text("Level 4"),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard when tapped outside of TextField
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                animal.imagePath,
                height: 200,
              ),
              SizedBox(height: 20), // Adjust the space between image and text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  enabled: !showNextLevelButton, // Disable text typing if showNextLevelButton is true
                  textCapitalization: TextCapitalization.characters, // Convert input to uppercase
                  onChanged: (value) {
                    setState(() {
                      userAnswer = value.toUpperCase(); // Convert to capital letters
                    });
                  },
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), // Bold and smaller text
                  decoration: InputDecoration(
                    labelText: "Type the animal name",
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call _checkAnswer() only when submit button is pressed
                  _checkAnswer();
                },
                child: Text("Submit"),
              ),
              if (showNextLevelButton) // Display Next Level button if showNextLevelButton is true
                ElevatedButton(
                  onPressed: () {
                    _goToNextLevel();
                  },
                  child: Text("Next Level"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer() {
    String trimmedAnswer = userAnswer!.trim().toUpperCase(); // Trim the user's answer
    if (trimmedAnswer == animal.name.toUpperCase()) { // Check uppercase
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Correct!'),
        duration: Duration(milliseconds: 700),
      ));
      setState(() {
        if(score==3){
          score = 4;
          _updateScoreInFirebase();
        }
        controller.text = animal.name.toUpperCase(); // Display correct answer in uppercase on TextField
        showNextLevelButton = true; // Show Next Level button
      });
      FocusScope.of(context).unfocus(); // Dismiss keyboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Incorrect. Try again!'),
        duration: Duration(milliseconds: 700),
      ));
    }
  }

  void _goToNextLevel() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessingGame5(
        username: widget.username, email: widget.email, age: widget.age)));
  }

  void _updateScoreInFirebase() async {
    // Only update score if level is completed
    if (score == 4) {
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

  Animal({
    required this.name,
    required this.imagePath,
  });
}

// old code
//
// import 'package:flutter/material.dart';
// import 'package:game/category1/game1/guess/GuessingGame3.dart';
// import 'package:game/category1/game1/guess/GuessingGame5.dart';
// import 'package:game/category1/game1/guess/levelguess.dart';
//
// class GuessingGame4 extends StatefulWidget {
//   const GuessingGame4({Key? key}) : super(key: key);
//
//   @override
//   _GuessingGame4State createState() => _GuessingGame4State();
// }
//
// class _GuessingGame4State extends State<GuessingGame4> {
//   int score = 0;
//   int totalPoints = 0;
//
//
//   List<Animal> animals = [
//     Animal(name: 'Lion', imagePath: 'assets/animals/lion.png', points: 1),
//     Animal(name: 'Cat', imagePath: 'assets/animals/cat.png', points: 1),
//   //  Animal(name: 'Goat', imagePath: 'assets/animals/goat.png', points: 1),
//   ];
//
//   List<Animal> shuffledAnimals = [];
//
//   List<List<Animal>> allAnimalCategories = [];
//
//   int currentCategoryIndex = 0;
//
//   bool showNextLevelButton = false;
//
//   @override
//   void initState() {
//     super.initState();
//     allAnimalCategories.add(animals);
//     shuffledAnimals = List.from(allAnimalCategories[currentCategoryIndex])..shuffle();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Level 4'),
//         backgroundColor: Colors.blue.shade200,
//         // actions: [
//         //   IconButton(
//         //     icon: const Icon(Icons.refresh),
//         //     onPressed: _shuffleAnimals,
//         //   ),
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),
//               GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: shuffledAnimals.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return AnimalCard(
//                     animal: shuffledAnimals[index],
//                     onMatched: () {
//                       setState(() {
//                         score += shuffledAnimals[index].points!;
//                         totalPoints += shuffledAnimals[index].points!;
//                         shuffledAnimals[index].matched = true;
//
//                         // Check if all animals are matched
//                         if (shuffledAnimals.every((animal) => animal.matched)) {
//                           _showGameCompletedDialog();
//                         }
//                       });
//                     },
//                   );
//                 },
//               ),
//               SizedBox(height: 50,),
//               Text('Score: $score', style: const TextStyle(fontSize: 30)),
//
//               if (showNextLevelButton)
//                 Padding(
//                   padding: const EdgeInsets.all(70.0),
//                   child: Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (
//                               context) => LevelSelection()));
//                         },
//                         child: const Text("Home"),
//                       ),
//                       SizedBox(width: 20,),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (
//                               context) => GuessingGame5()));
//                         },
//                         child: const Text("Next Level"),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void _shuffleAnimals() {
//   //   setState(() {
//   //     // Increment the category index, and loop back to 0 if it exceeds the length
//   //     currentCategoryIndex = (currentCategoryIndex + 1) % allAnimalCategories.length;
//   //     // Shuffle the animals of the current category
//   //     shuffledAnimals = List.from(allAnimalCategories[currentCategoryIndex])..shuffle();
//   //     // Reset the score
//   //     score = 0;
//   //     // Reset the showNextLevelButton flag
//   //     showNextLevelButton = false;
//   //   });
//   // }
//
//   void _showGameCompletedDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
//       builder: (context) {
//         totalPoints += score;
//         return AlertDialog(
//           title: const Text('Level 4 Completed'),
//           content: Text('Congratulations! Your total score: $totalPoints'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _showNextLevelButton(); // Show the next level button
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showNextLevelButton() {
//     setState(() {
//       showNextLevelButton = true;
//     });
//   }
// }
//
// class Animal {
//   final String name;
//   final String imagePath;
//   final int? points;
//   bool matched;
//
//   Animal({
//     required this.name,
//     required this.imagePath,
//     this.points,
//     this.matched = false,
//   });
// }
//
// class AnimalCard extends StatefulWidget {
//   final Animal animal;
//   final Function() onMatched;
//
//   AnimalCard({Key? key, required this.animal, required this.onMatched}) : super(key: key);
//
//   @override
//   _AnimalCardState createState() => _AnimalCardState();
// }
//
// class _AnimalCardState extends State<AnimalCard> {
//   TextEditingController textEditingController = TextEditingController();
//   String typedName = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!widget.animal.matched) {
//           _showAnimalNameDialog(context);
//         }
//       },
//       child: Card(
//         elevation: 3,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 widget.animal.matched ? widget.animal.imagePath : widget.animal.imagePath,
//                 height: 100,
//                 width: 80,
//               ),
//             ),
//             if (typedName.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   '$typedName',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAnimalNameDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Padding(
//             padding: const EdgeInsets.all(26.0),
//             child: const Text('Guess the animal?'),
//           ),
//           content: Column(
//             children: [
//               const SizedBox(height: 20),
//               TextField(
//                 controller: textEditingController,
//                 onChanged: (value) {
//                   setState(() {
//                     typedName = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Type the animal name',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextButton(
//                 onPressed: () {
//                   String enteredName = typedName.trim();
//                   if (enteredName.isNotEmpty &&
//                       enteredName.toLowerCase() == widget.animal.name.toLowerCase()) {
//                     Navigator.pop(context);
//                     widget.onMatched();
//                   } else {
//                     // Show incorrect guess message
//                     _showIncorrectGuessDialog(context);
//                   }
//                 },
//                 child: const Text('Match'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showIncorrectGuessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Wrong Guess'),
//           content: const Text('Incorrect guess! Please try again.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
