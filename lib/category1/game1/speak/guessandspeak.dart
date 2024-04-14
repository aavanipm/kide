import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/speak/guessandspeak1.dart';
import 'package:game/category1/game1/speak/guessandspeak10.dart';
import 'package:game/category1/game1/speak/guessandspeak11.dart';
import 'package:game/category1/game1/speak/guessandspeak12.dart';
import 'package:game/category1/game1/speak/guessandspeak13.dart';
import 'package:game/category1/game1/speak/guessandspeak14.dart';
import 'package:game/category1/game1/speak/guessandspeak15.dart';
import 'package:game/category1/game1/speak/guessandspeak16.dart';
import 'package:game/category1/game1/speak/guessandspeak17.dart';
import 'package:game/category1/game1/speak/guessandspeak18.dart';
import 'package:game/category1/game1/speak/guessandspeak19.dart';
import 'package:game/category1/game1/speak/guessandspeak2.dart';
import 'package:game/category1/game1/speak/guessandspeak20.dart';
import 'package:game/category1/game1/speak/guessandspeak3.dart';
import 'package:game/category1/game1/speak/guessandspeak4.dart';
import 'package:game/category1/game1/speak/guessandspeak5.dart';
import 'package:game/category1/game1/speak/guessandspeak6.dart';
import 'package:game/category1/game1/speak/guessandspeak7.dart';
import 'package:game/category1/game1/speak/guessandspeak8.dart';
import 'package:game/category1/game1/speak/guessandspeak9.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';

class GuessSpeakLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const GuessSpeakLevel({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<GuessSpeakLevel> createState() => _GuessSpeakLevelState();
}

class _GuessSpeakLevelState extends State<GuessSpeakLevel> {
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
            if (gameScores.containsKey('speaking')) {
              score = gameScores['speaking']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }


  List<GuessSpeak> values = [
    GuessSpeak(name: "1"),
    GuessSpeak(name: "2"),
    GuessSpeak(name: "3"),
    GuessSpeak(name: "4"),
    GuessSpeak(name: "5"),
    GuessSpeak(name: "6"),
    GuessSpeak(name: "7"),
    GuessSpeak(name: "8"),
    GuessSpeak(name: "9"),
    GuessSpeak(name: "10"),
    GuessSpeak(name: "11"),
    GuessSpeak(name: "12"),
    GuessSpeak(name: "13"),
    GuessSpeak(name: "14"),
    GuessSpeak(name: "15"),
    GuessSpeak(name: "16"),
    GuessSpeak(name: "17"),
    GuessSpeak(name: "18"),
    GuessSpeak(name: "19"),
    GuessSpeak(name: "20"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"),
        actions: [
          IconButton(
            onPressed: () {
              _navigate(widget.age);
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

  Future<void> _navigate(String age) async {
    int ageInt = int.tryParse(age) ?? 0; // Convert age to an integer

    if (ageInt == 2 || ageInt == 3 || ageInt == 4 || ageInt == 5) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home1(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory, // Update subscribed category
          ),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home2(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory, // Update subscribed category
          ),
        ),
      );
    }
  }

  Widget fillcard(BuildContext context, GuessSpeak val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak1(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak7(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak8(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak9(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak10(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak16(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '17':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak17(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '18':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak18(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '19':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak19(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '20':
              Navigator.push(context, MaterialPageRoute(builder: (context) => GuessandSpeak17(
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

class GuessSpeak{
  final String name;

  GuessSpeak({required this.name});
}