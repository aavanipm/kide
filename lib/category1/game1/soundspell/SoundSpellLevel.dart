import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/soundspell/soundspell1.dart';
import 'package:game/category1/game1/soundspell/soundspell10.dart';
import 'package:game/category1/game1/soundspell/soundspell11.dart';
import 'package:game/category1/game1/soundspell/soundspell12.dart';
import 'package:game/category1/game1/soundspell/soundspell13.dart';
import 'package:game/category1/game1/soundspell/soundspell14.dart';
import 'package:game/category1/game1/soundspell/soundspell15.dart';
import 'package:game/category1/game1/soundspell/soundspell16.dart';
import 'package:game/category1/game1/soundspell/soundspell17.dart';
import 'package:game/category1/game1/soundspell/soundspell18.dart';
import 'package:game/category1/game1/soundspell/soundspell19.dart';
import 'package:game/category1/game1/soundspell/soundspell2.dart';
import 'package:game/category1/game1/soundspell/soundspell20.dart';
import 'package:game/category1/game1/soundspell/soundspell3.dart';
import 'package:game/category1/game1/soundspell/soundspell4.dart';
import 'package:game/category1/game1/soundspell/soundspell6.dart';
import 'package:game/category1/game1/soundspell/soundspell7.dart';
import 'package:game/category1/game1/soundspell/soundspell5.dart';
import 'package:game/category1/game1/soundspell/soundspell8.dart';
import 'package:game/category1/game1/soundspell/soundspell9.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';

class SoundSpellLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SoundSpellLevel({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<SoundSpellLevel> createState() => _SoundSpellLevelState();
}

class _SoundSpellLevelState extends State<SoundSpellLevel> {
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
        Map<String, dynamic> gameData = documentSnapshot.data() as Map<String, dynamic>;
        if (gameData.containsKey('gameData')) {
          Map<String, dynamic> gameScores = gameData['gameData'];
          if (gameScores.containsKey('spell')) {
            score = gameScores['spell']['score'];
            setState(() {}); // Update state after retrieving score
          }
        }
      }
    }
  }


  List<SoundSpell> values = [
    SoundSpell(name: "1"),
    SoundSpell(name: "2"),
    SoundSpell(name: "3"),
    SoundSpell(name: "4"),
    SoundSpell(name: "5"),
    SoundSpell(name: "6"),
    SoundSpell(name: "7"),
    SoundSpell(name: "8"),
    SoundSpell(name: "9"),
    SoundSpell(name: "10"),
    SoundSpell(name: "11"),
    SoundSpell(name: "12"),
    SoundSpell(name: "13"),
    SoundSpell(name: "14"),
    SoundSpell(name: "15"),
    SoundSpell(name: "16"),
    SoundSpell(name: "17"),
    SoundSpell(name: "18"),
    SoundSpell(name: "19"),
    SoundSpell(name: "20"),
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
                return Spellcard(context, values[index]);
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

  Widget Spellcard(BuildContext context, SoundSpell val) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell1(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell2(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell3(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '4':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell4(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '5':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell5(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '6':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell6(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

          case '8':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell8(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '9':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell9(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
          break;

          case '10':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell10(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
          break;

            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell11(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell12(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell13(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell14(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell15(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell16(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '17':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell17(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '18':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell18(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '19':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell19(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;

            case '20':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpell20(
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

class SoundSpell{
  final String name;

  SoundSpell({required this.name});
}
