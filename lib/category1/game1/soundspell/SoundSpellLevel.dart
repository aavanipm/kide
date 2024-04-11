import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/soundspell/soundspell1.dart';
import 'package:game/category1/game1/soundspell/soundspell2.dart';
import 'package:game/category1/game1/soundspell/soundspell3.dart';
import 'package:game/category1/game1/soundspell/soundspell4.dart';
import 'package:game/category1/game1/soundspell/sounspell5.dart';
import 'package:game/category1/home1.dart';

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
                return fillcard(context, values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget fillcard(BuildContext context,SoundSpell val){

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
      onTap: (){
      if (canPlay) {
        switch(val.name){
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
          //
          // case '6':
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard6(
          //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
          //   )));
          //   break;

          // case '7':
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard7()));
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


class SoundSpell{
  final String name;

  SoundSpell({required this.name});
}
