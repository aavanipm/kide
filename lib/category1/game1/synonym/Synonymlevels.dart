import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/synonym/syndemo.dart';
import 'package:game/category1/game1/synonym/synonym2.dart';
import 'package:game/category1/home1.dart';

class Synonymlevels extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Synonymlevels({Key? key, required this.username,
    required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

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
    FirebaseFirestore.instance.collection(widget.username).doc('synonym');
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
    Synonym(name: "9"),
    Synonym(name: "10"),
    Synonym(name: "11"),
    Synonym(name: "12"),
    Synonym(name: "13"),
    Synonym(name: "14"),
    Synonym(name: "15"),
    Synonym(name: "16"),
    Synonym(name: "17"),
    Synonym(name: "18"),
    Synonym(name: "19"),
    Synonym(name: "20"),
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

  Widget fillcard(BuildContext context, Synonym val) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SynonymFinderScreen(
                // username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
              )));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Synonym2(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
              break;
            // case '3':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Synonym3(
            //     username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,)));
            //   break;
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

class Synonym{
  final String name;

  Synonym({required this.name});
}