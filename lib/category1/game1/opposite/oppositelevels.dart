import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/opposite/opposite1.dart';
import 'package:game/category1/game1/opposite/opposite10.dart';
import 'package:game/category1/game1/opposite/opposite11.dart';
import 'package:game/category1/game1/opposite/opposite12.dart';
import 'package:game/category1/game1/opposite/opposite13.dart';
import 'package:game/category1/game1/opposite/opposite14.dart';
import 'package:game/category1/game1/opposite/opposite15.dart';
import 'package:game/category1/game1/opposite/opposite16.dart';
import 'package:game/category1/game1/opposite/opposite2.dart';
import 'package:game/category1/game1/opposite/opposite3.dart';
import 'package:game/category1/game1/opposite/opposite4.dart';
import 'package:game/category1/game1/opposite/opposite5.dart';
import 'package:game/category1/game1/opposite/opposite6.dart';
import 'package:game/category1/game1/opposite/opposite7.dart';
import 'package:game/category1/game1/opposite/opposite8.dart';
import 'package:game/category1/game1/opposite/opposite9.dart';
import 'package:game/category1/home1.dart';

class Oppositelevels extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Oppositelevels({Key? key, required this.username,
    required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Oppositelevels> createState() => _OppositelevelsState();
}

class _OppositelevelsState extends State<Oppositelevels> {
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
      // Retrieve score for opposite game
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('games')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('opposite')) {
            score = gameScores['opposite']['score'] ?? 0; // Default score to 0 if not found
          }
        }
      }
    }
  }

  List<Opposite> values = [
    Opposite(name: "1"),
    Opposite(name: "2"),
    Opposite(name: "3"),
    Opposite(name: "4"),
    Opposite(name: "5"),
    Opposite(name: "6"),
    Opposite(name: "7"),
    Opposite(name: "8"),
    Opposite(name: "9"),
    Opposite(name: "10"),
    Opposite(name: "11"),
    Opposite(name: "12"),
    Opposite(name: "13"),
    Opposite(name: "14"),
    Opposite(name: "15"),
    Opposite(name: "16"),
    Opposite(name: "17"),
    Opposite(name: "18"),
    Opposite(name: "19"),
    Opposite(name: "20"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home1(
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: values.length,
              itemBuilder: (context, index){
                return fillcard(context, values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget fillcard(BuildContext context, Opposite val) {
    bool isUnlocked = int.parse(val.name) <= 5; // Default only levels 1-5 unlocked
    if (widget.subscribedCategory == "basic") {
      isUnlocked = int.parse(val.name) <= 10; // Unlock levels 1-10 for basic subscription
    } else if (widget.subscribedCategory == "standard") {
      isUnlocked = int.parse(val.name) <= 15; // Unlock levels 1-15 for standard subscription
    } else if (widget.subscribedCategory == "premium") {
      isUnlocked = int.parse(val.name) <= 20; // Unlock all levels for premium subscription
    }

    // Check if the level is unlocked and the previous level is completed
    bool canPlay = isUnlocked && (int.parse(val.name) == 1 || int.parse(val.name) <= score + 1);

    Color? cardColor = canPlay ? Colors.blue.shade100 : Colors.grey.shade100;

    return GestureDetector(
      onTap: () {
        if (canPlay) {
          // Navigate to the level screen based on val.name
          switch (val.name) {
            case '1':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite8(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite9(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite10(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Opposite16(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
              break;
            default:
              break;
          }
        } else {
          // Show a dialog indicating the level is locked or subscription needed
          String message;
          if (int.parse(val.name) > score + 1) {
            message = 'Complete the previous level to unlock this one.';
          } else {
            message = 'Subscribe to access more levels.';
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Level Locked'),
                content: Text(message),
                actions: [
                  if (int.parse(val.name) > score + 1)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  if (int.parse(val.name) <= score + 1)
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
                  color: isUnlocked ? Colors.black : Colors.grey, // Text color based on unlocked status
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Opposite{
  final String name;

  Opposite({required this.name});
}