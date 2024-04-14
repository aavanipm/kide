import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/search/Search1.dart';
import 'package:game/category1/game1/search/Search2.dart';
import 'package:game/category1/game1/search/Search3.dart';
import 'package:game/category1/game1/search/Search4.dart';
import 'package:game/category1/game1/search/Search5.dart';
import 'package:game/category1/game1/search/Search6.dart';
import 'package:game/category1/game1/search/Search7.dart';
import 'package:game/category1/game1/search/search10.dart';
import 'package:game/category1/game1/search/search8.dart';
import 'package:game/category1/game1/search/search9.dart';
import 'package:game/category1/home1.dart';

class SearchLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SearchLevel({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);
  @override
  State<SearchLevel> createState() => _SearchLevelState();
}

class _SearchLevelState extends State<SearchLevel> {
  int score = 0;
  List<String> foundWords = []; // Stores found words

  @override
  void initState(){
    super.initState();
    _getStoredScore();
  }

  void _getStoredScore() async {
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
          if (gameScores.containsKey('wordsearch')) {
            setState(() {
              score = gameScores['wordsearch']['score'] ?? 0;
              foundWords = List<String>.from(gameScores['wordsearch']['foundWords'] ?? []);
            });
          }
        }
      }
    }
  }

  List<Search> values = [
    Search(name: "1"),
    Search(name: "2"),
    Search(name: "3"),
    Search(name: "4"),
    Search(name: "5"),
    Search(name: "6"),
    Search(name: "7"),
    Search(name: "8"),
    Search(name: "9"),
    Search(name: "10"),
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
  Widget levelcard(BuildContext context, Search val) {
    // Define a map with level numbers as keys and required scores as values
    Map<String, int> levelScores = {
      "1": 0, // Score required for level 1
      "2": 4, // Score required for level 2
      "3": 8, // Score required for level 3
      "4": 12, // Score required for level 4
      "5": 16, // Score required for level 5
      "6": 20, // Score required for level 6
      "7": 24,
      "8": 29,
      "9": 34,
      "10": 39,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search3(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;
          case '4':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search4(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '5':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search5(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '6':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search6(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '7':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search7(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '8':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search8(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '9':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search9(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          case '10':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search10(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
            )));
            break;
          default:
            break;break;
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

class Search {
  final String name;

  Search({required this.name});
}
