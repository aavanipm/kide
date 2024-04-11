import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/guess/GuessingGame1.dart';
import 'package:game/category1/game1/guess/GuessingGame2.dart';
import 'package:game/category1/game1/guess/GuessingGame3.dart';
import 'package:game/category1/game1/guess/GuessingGame4.dart';
import 'package:game/category1/game1/guess/GuessingGame5.dart';
import 'package:game/category1/game1/guess/GuessingGame6.dart';
import 'package:game/category1/game1/guess/Guessinggame7.dart';
import 'package:game/category1/game1/guess/guessinggame12.dart';
import 'package:game/category1/game1/guess/guessinggame13.dart';
import 'package:game/category1/game1/guess/guessinggame14.dart';
import 'package:game/category1/game1/guess/guessinggame15.dart';
import 'package:game/category1/game1/guess/guessinggame16.dart';
import 'package:game/category1/game1/guess/guessinggame8.dart';
import 'package:game/category1/game1/guess/guessinggame9.dart';
import 'package:game/category1/game1/guess/Guessinggame10.dart';
import 'package:game/category1/game1/guess/Guessinggame11.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/home1.dart';

class LevelGuess extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  LevelGuess({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<LevelGuess> createState() => _LevelGuessState();
}

class _LevelGuessState extends State<LevelGuess> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        setState(() { // Trigger UI rebuild
          Map<String, dynamic> gameData = documentSnapshot.data() as Map<
              String,
              dynamic>;
          if (gameData.containsKey('gameData')) {
            Map<String, dynamic> gameScores = gameData['gameData'];
            if (gameScores.containsKey('guessing')) {
              score = gameScores['guessing']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }

  List<Guess> values = [
    Guess(name: "1"),
    Guess(name: "2"),
    Guess(name: "3"),
    Guess(name: "4"),
    Guess(name: "5"),
    Guess(name: "6"),
    Guess(name: "7"),
    Guess(name: "8"),
    Guess(name: "9"),
    Guess(name: "10"),
    Guess(name: "11"),
    Guess(name: "12"),
    Guess(name: "13"),
    Guess(name: "14"),
    Guess(name: "15"),
    Guess(name: "16"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory)));
            },
            icon: Icon(Icons.home), // Home button on the right side
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: values.length,
              itemBuilder: (context, index) {
                return guesscard(context, values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget guesscard(BuildContext context, Guess val) {

    Map<String, int> levelScores = {
      "1": 0, // Score required for level 1
      "2": 1, // Score required for level 2
      "3": 2, // Score required for level 3
      "4": 3, // Score required for level 4
      "5": 4, // Score required for level 5
      "6": 6, // Score required for level 6
      "7": 8, // Score required for level 7
      "8": 10,
      "9": 12,
      "10": 16,
      "11": 20,
      "12": 24,
      "13": 28,
      "14": 32,
      "15": 36,
      "16": 40,
    };

    bool isUnlocked = int.parse(val.name) <= 5; // Default only levels 1-5 unlocked
    if (widget.subscribedCategory == "basic") {
      isUnlocked = int.parse(val.name) <= 10; // Unlock levels 1-10 for basic subscription
    } else if (widget.subscribedCategory == "standard") {
      isUnlocked = int.parse(val.name) <= 15; // Unlock levels 1-15 for standard subscription
    } else if (widget.subscribedCategory == "premium") {
      isUnlocked = int.parse(val.name) <= 20; // Unlock all levels for premium subscription
    }

    bool canPlay = isUnlocked && (int.parse(val.name) == 1 || score >= levelScores[val.name]!);
    Color? cardColor = canPlay ? Colors.blue.shade100 : Colors.grey.shade100;

    return GestureDetector(
      onTap: () {
        if (canPlay) {
          switch (val.name) {
            case '1':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame8(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame9(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame10(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessingGame15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case 16:
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessingGame16()));
              break;
            default:
              break;
          }
        } else {
          String message;
          if (score >= levelScores[val.name]!) {
            message = 'Subscribe to access more levels.';
          } else {
            message = 'Complete the previous level to unlock this one.';
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Level Locked'),
                content: Text(message),
                actions: [
                  if (score >= levelScores[val.name]!)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  if (score <= levelScores[val.name]!)
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                            username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
                        )));
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
      },
      child: Card(
        elevation: 3,
        color: cardColor, // Assigning the card color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                val.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: isUnlocked ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Guess {
  final String name;

  Guess({required this.name});
}
