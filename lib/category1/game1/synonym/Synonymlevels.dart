import 'package:flutter/material.dart';
import 'package:game/category1/game1/synonym/synonym2.dart';
import 'package:game/category1/game1/synonym/Synonym5.dart';
import 'package:game/category1/game1/synonym/synonym1.dart';
import 'package:game/category1/game1/synonym/synonym3.dart';
import 'package:game/category1/game1/synonym/synonym4.dart';
import 'package:game/category1/game1/synonym/synonym6.dart';
import 'package:game/category1/game1/synonym/synonym7.dart';
import 'package:game/category1/game1/synonym/synonym8.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Synonymlevels extends StatefulWidget {
  const Synonymlevels({super.key});

  @override
  State<Synonymlevels> createState() => _SynonymlevelsState();
}

class _SynonymlevelsState extends State<Synonymlevels> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection('synonym').doc('userScore');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
  }

  List<Synonym> values = [
    Synonym(name: "1"),
    Synonym(name: "2"),
    Synonym(name: "3"),
    Synonym(name: "4"),
    Synonym(name: "5"),
    Synonym(name: "6"),
    Synonym(name: "7"),
    Synonym(name: "8"),
    // Synonym(name: "9"),
    // Synonym(name: "10"),
    // Synonym(name: "11"),
    // Synonym(name: "12"),
    // Synonym(name: "13"),
    // Synonym(name: "14"),
    // Synonym(name: "15"),
    // Synonym(name: "16"),
    // Synonym(name: "17"),
    // Synonym(name: "18"),
    // Synonym(name: "19"),
    // Synonym(name: "20"),
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
                return syncard(context, values[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget syncard(BuildContext context, Synonym val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym1()));
              break;

            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym2()));
              break;

            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym3()));
              break;

            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym4()));
              break;

            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym5()));
              break;

            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym6()));
              break;

            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym7()));
              break;

            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonym8()));
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

class Synonym{
  final String name;

  Synonym({required this.name});
}