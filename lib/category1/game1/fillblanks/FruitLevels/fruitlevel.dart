import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit1.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit10.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit11.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit12.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit13.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit14.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit15.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit16.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit2.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit3.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit4.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit5.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit6.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit7.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit8.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/fruit9.dart';

class FruitLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const FruitLevel({Key? key, required this.username, required this.email, required this.age}) : super(key: key);

  @override
  State<FruitLevel> createState() => _FruitLevelState();
}

class _FruitLevelState extends State<FruitLevel> {
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
      if (data.containsKey('fruit')) {
        setState(() {
          score = data['fruit']['score'];
        });
      }
    }
  }

  List<Fruit> values = [
    Fruit(name: "1"),
    Fruit(name: "2"),
    Fruit(name: "3"),
    Fruit(name: "4"),
    Fruit(name: "5"),
    Fruit(name: "6"),
    Fruit(name: "7"),
    Fruit(name: "8"),
    Fruit(name: "9"),
    Fruit(name: "10"),
    Fruit(name: "11"),
    Fruit(name: "12"),
    Fruit(name: "13"),
    Fruit(name: "14"),
    Fruit(name: "15"),
    Fruit(name: "16"),
    // Fruit(name: "17"),
    // Fruit(name: "18"),
    // Fruit(name: "19"),
    // Fruit(name: "20"),
    // Fruit(name: "21"),
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

  Widget fillcard(BuildContext context, Fruit val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit1(
                  username: widget.username, email: widget.email, age: widget.age)));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit2(
                username: widget.username, email: widget.email, age: widget.age,)));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit3(
                username: widget.username, email: widget.email, age: widget.age,)));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit4(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit5(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit6(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit7(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit8(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit9(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit10(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit11(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '12':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit12(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '13':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit13(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '14':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit14(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '15':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit15(
                  username: widget.username, email: widget.email, age: widget.age
              )));
              break;
            case '16':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit16()));
              break;
            // case '17':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Bird17(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '18':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Bird18(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '19':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Bird19(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '20':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Bird20(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            // case '21':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Bird21()));
            //   break;
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

class Fruit{
  final String name;

  Fruit({required this.name});
}