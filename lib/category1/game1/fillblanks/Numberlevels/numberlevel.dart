import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/number1.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/number2.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/number3.dart';
import 'package:game/category1/home1.dart';

class NumberLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const NumberLevel({Key? key, required this.username,
    required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<NumberLevel> createState() => _NumberLevelState();
}

class _NumberLevelState extends State<NumberLevel> {
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
            if (gameScores.containsKey('fillblanksnumber')) {
              score = gameScores['fillblanksnumber']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }

  List<Number> values = [
    Number(name: "1"),
    Number(name: "2"),
    Number(name: "3"),
    Number(name: "4"),
    Number(name: "5"),
    Number(name: "6"),
    Number(name: "7"),
    Number(name: "8"),
    Number(name: "9"),
    Number(name: "10"),
    Number(name: "11"),
    Number(name: "12"),
    Number(name: "13"),
    Number(name: "14"),
    Number(name: "15"),
    Number(name: "16"),
    Number(name: "17"),
    Number(name: "18"),
    Number(name: "19"),
    Number(name: "20"),
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

  Widget fillcard(BuildContext context, Number val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Number1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Number2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Number3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            // case '4':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill4(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
            //   break;
            // case '5':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill5(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
            //   break;
            // case '6':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill6(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '7':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill7(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '8':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill8(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '9':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill9(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '10':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill10(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '11':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill11(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '12':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill12(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '13':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill13(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '14':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill14(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '15':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill15(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '16':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill16(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '17':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill17(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '18':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill18(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '19':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill19(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
            // case '20':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill20(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,              )));
            //   break;
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

class Number{
  final String name;

  Number({required this.name});
}