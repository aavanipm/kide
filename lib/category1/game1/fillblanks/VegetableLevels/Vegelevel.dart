import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg1.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg10.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg11.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg2.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg3.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg4.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg5.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg6.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg7.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg8.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/veg9.dart';
import 'package:game/category1/home1.dart';

class VegeLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const VegeLevel({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<VegeLevel> createState() => _VegeLevelState();
}

class _VegeLevelState extends State<VegeLevel> {
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
            if (gameScores.containsKey('fillblanksvegetable')) {
              score = gameScores['fillblanksvegetable']['score']; // Default score to 0 if not found
            }
          }
        });
      }
    }
  }

  List<Vegetable> values = [
    Vegetable(name: "1"),
    Vegetable(name: "2"),
    Vegetable(name: "3"),
    Vegetable(name: "4"),
    Vegetable(name: "5"),
    Vegetable(name: "6"),
    Vegetable(name: "7"),
    Vegetable(name: "8"),
    Vegetable(name: "9"),
    Vegetable(name: "10"),
    Vegetable(name: "11"),
    Vegetable(name: "12"),
    // Vegetable(name: "13"),
    // Vegetable(name: "14"),
    // Vegetable(name: "15"),
    // Vegetable(name: "16"),
    // Fruit(name: "17"),
    // Fruit(name: "18"),
    // Fruit(name: "19"),
    // Fruit(name: "20"),
    // Fruit(name: "21"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

  Widget fillcard(BuildContext context, Vegetable val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg3(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg8(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg9(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg10(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '11':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Veg11(
                  username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            // case '12':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit12(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '13':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit13(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '14':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit14(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '15':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit15(
            //       username: widget.username, email: widget.email, age: widget.age
            //   )));
            //   break;
            // case '16':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fruit16()));
            //   break;
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

class Vegetable{
  final String name;

  Vegetable({required this.name});
}