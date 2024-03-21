import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class BirdLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const BirdLevel({Key? key, required this.username, required this.email, required this.age}) : super(key: key);

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
    final DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(widget.username)
        .doc('fillblanks');

    final DocumentSnapshot snapshot = await userDocRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('bird')) {
        setState(() {
          score = data['bird']['score'];
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
    Bird(name: "21"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    bool isUnlocked = val.name == "1" || int.parse(val.name) <= score+1; // Level 1 or score high enough
    Color? cardColor = isUnlocked ? Colors.blue.shade100 : Colors.grey.shade100;
    Text(
      val.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: isUnlocked ? Colors.black : Colors.grey, // Text color based on unlocked status
      ),
    );
    return GestureDetector(
      onTap: () {
        if (isUnlocked) {
          // Navigate to the level screen based on val.name
          switch (val.name) {
            case '1':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird1(
                  username: widget.username, email: widget.email, age: widget.age)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird2(
                username: widget.username, email: widget.email, age: widget.age,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird3(
                username: widget.username, email: widget.email, age: widget.age,)));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird4(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird5(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird6(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird7(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird8(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird9(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird10(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird11(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird12(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird13(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird14(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird15(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird16(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '17':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird17(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '18':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird18(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '19':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird19(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '20':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird20(
                  username: widget.username, email: widget.email, age: widget.age
              )));
            case '21':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bird21()));
              break;
            default:
              break;
          }
        } else {
          // Show a dialog indicating the level is locked
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Level Locked'),
                content: Text('This level is locked. You need to complete previous level to unlock it.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
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