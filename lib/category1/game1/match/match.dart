import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/match/match1.dart';
import 'package:game/category1/game1/match/match10.dart';
import 'package:game/category1/game1/match/match11.dart';
import 'package:game/category1/game1/match/match12.dart';
import 'package:game/category1/game1/match/match13.dart';
import 'package:game/category1/game1/match/match14.dart';
import 'package:game/category1/game1/match/match15.dart';
import 'package:game/category1/game1/match/match16.dart';
import 'package:game/category1/game1/match/match17.dart';
import 'package:game/category1/game1/match/match18.dart';
import 'package:game/category1/game1/match/match19.dart';
import 'package:game/category1/game1/match/match2.dart';
import 'package:game/category1/game1/match/match20.dart';
import 'package:game/category1/game1/match/match3.dart';
import 'package:game/category1/game1/match/match4.dart';
import 'package:game/category1/game1/match/match5.dart';
import 'package:game/category1/game1/match/match6.dart';
import 'package:game/category1/game1/match/match7.dart';
import 'package:game/category1/game1/match/match8.dart';
import 'package:game/category1/game1/match/match9.dart';
import 'package:game/category1/home1.dart';

class Match extends StatefulWidget {

  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Match({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  int score = 0;

  @override
  void initState(){
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
            if (gameScores.containsKey('matching')) {
              score = gameScores['matching']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }

  List<Matching> values = [
    Matching(name: "1"),
    Matching(name: "2"),
    Matching(name: "3"),
    Matching(name: "4"),
    Matching(name: "5"),
    Matching(name: "6"),
    Matching(name: "7"),
    Matching(name: "8"),
    Matching(name: "9"),
    Matching(name: "10"),
    Matching(name: "11"),
    Matching(name: "12"),
    Matching(name: "13"),
    Matching(name: "14"),
    Matching(name: "15"),
    Matching(name: "16"),
    Matching(name: "17"),
    Matching(name: "18"),
    Matching(name: "19"),
    Matching(name: "20"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"), backgroundColor: Colors.blue.shade100,
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: values.length,
              itemBuilder: (context, index){
                return levelcard(context, values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget levelcard(BuildContext context, Matching val) {
    // Define a map with level numbers as keys and required scores as values
    Map<String, int> levelScores = {
      "1": 0, // Score required for level 1
      "2": 4, // Score required for level 2
      "3": 8, // Score required for level 3
      "4": 12, // Score required for level 4
      "5": 16, // Score required for level 5
      "6": 20, // Score required for level 6
      "7": 24,
      "8": 28,
      "9": 32,
      "10": 36,
      "11": 40,
      "12": 45,
      "13": 50,
      "14": 55,
      "15": 59,
      "16": 63,
      "17": 68,
      "18": 72,
      "19": 76,
      "20": 80,
    };

    bool isUnlocked = int.parse(val.name) <= 5; // Default only levels 1-5 unlocked
    if (widget.subscribedCategory == "basic") {
      isUnlocked = int.parse(val.name) <= 10; // Unlock levels 1-10 for basic subscription
    } else if (widget.subscribedCategory == "standard") {
      isUnlocked = int.parse(val.name) <= 15; // Unlock levels 1-15 for standard subscription
    } else if (widget.subscribedCategory == "premium") {
      isUnlocked = int.parse(val.name) <= 20; // Unlock all levels for premium subscription
    }
    // Check if the level is unlocked based on the current score
    bool canPlay = isUnlocked && (int.parse(val.name) == 1 || score >= levelScores[val.name]!);

    Color? cardColor = canPlay ? Colors.blue.shade100 : Colors.grey.shade100;

    return GestureDetector(
      onTap: () {
        if (canPlay) {
          // Navigation logic remains the same
          switch (val.name) {
            case '1':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '2':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '3':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '4':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '5':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '6':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '7':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '8':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match8(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '9':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match9(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '10':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match10(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '11':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '12':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '13':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '14':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '15':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '16':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match16(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '17':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  Match17(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '18':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match18(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '19':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match19(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '20':
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Match20(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
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
        color: cardColor,
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

class Matching{
  final String name;

  Matching({required this.name});
}
