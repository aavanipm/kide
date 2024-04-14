import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/Bird10.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/Bird11.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/Bird12.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/Bird13.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird1.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird14.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird15.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird16.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird17.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird18.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird19.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird2.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird20.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird21.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird3.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird4.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird5.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird6.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird7.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird8.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/bird9.dart';
import 'package:game/category1/home1.dart';

class BirdLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const BirdLevel({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<BirdLevel> createState() => _BirdLevelState();
}

class _BirdLevelState extends State<BirdLevel> {
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
            if (gameScores.containsKey('fillblanksbird')) {
              score = gameScores['fillblanksbird']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }


  List<Bird> values = [
    Bird(name: "1"),
    Bird(name: "2"),
    Bird(name: "3"),
    Bird(name: "4"),
    Bird(name: "5"),
    Bird(name: "6"),
    Bird(name: "7"),
    Bird(name: "8"),
    Bird(name: "9"),
    Bird(name: "10"),
    Bird(name: "11"),
    Bird(name: "12"),
    Bird(name: "13"),
    Bird(name: "14"),
    Bird(name: "15"),
    Bird(name: "16"),
    Bird(name: "17"),
    Bird(name: "18"),
    Bird(name: "19"),
    Bird(name: "20"),
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

  Widget fillcard(BuildContext context, Bird val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird1(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird4(
          username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird5(
          username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird8(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird9(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird10(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird16(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '17':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird17(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '18':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird18(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '19':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird19(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '20':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird20(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
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

class Bird{
  final String name;

  Bird({required this.name});
}