import 'package:flutter/material.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/fillblanks/AnimalLevels/levelsfill.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/BirdLevel.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/FruitLEvel.dart';
import 'package:game/category1/game1/fillblanks/Numberlevels/numberlevel.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/Vegelevel.dart';

class Fills extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Fills({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<Fills> createState() => _FillsState();
}

class _FillsState extends State<Fills> {
  List<Fill> values = [
    Fill(name: "ANIMALS"),
    Fill(name: "BIRDS"),
    Fill(name: "FRUITS"),
    Fill(name: "NUMBERS"),
    Fill(name: "VEGETABLES"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FILL IN THE BLANKS"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 6,
        ),
        shrinkWrap: true,
        itemCount: values.length,
        itemBuilder: (context, index) {
          return learncard(context, values[index]);
        },
      ),
    );
  }

  Widget learncard(BuildContext context, Fill val) {
    return GestureDetector(
      onTap: () {
        if (val.name == 'VEGETABLES') {
          // Check if the user is a premium subscriber before allowing access to vegetable level
          if (widget.subscribedCategory == 'premium') {
            navigateToVegetableLevel(context);
          } else {
            // Show a message or dialog indicating that this feature is for premium subscribers only
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Premium Feature"),
                content: Text("Unlock this feature by becoming a premium subscriber."),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                      username: widget.username,
                      email: widget.email,
                      age: widget.age,
                      subscribedCategory: widget.subscribedCategory,
                    )));
                  }, child: Text("Subscribe")),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        } else {
          // For other levels, proceed directly
          navigateToLevel(context, val.name);
        }
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              val.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToVegetableLevel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VegeLevel(
          username: widget.username,
          email: widget.email,
          age: widget.age,
          subscribedCategory: widget.subscribedCategory,
        ),
      ),
    );
  }

  void navigateToLevel(BuildContext context, String levelName) {
    switch (levelName) {
      case 'ANIMALS':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LevelFill(
              username: widget.username,
              email: widget.email,
              age: widget.age,
              subscribedCategory: widget.subscribedCategory,
            ),
          ),
        );
        break;
      case 'BIRDS':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BirdLevel(
              username: widget.username,
              email: widget.email,
              age: widget.age,
              subscribedCategory: widget.subscribedCategory,
            ),
          ),
        );
        break;
      case 'FRUITS':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FruitLevel(
              username: widget.username,
              email: widget.email,
              age: widget.age,
              subscribedCategory: widget.subscribedCategory,
            ),
          ),
        );
        break;
      case 'NUMBERS':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberLevel(
              username: widget.username,
              email: widget.email,
              age: widget.age,
              subscribedCategory: widget.subscribedCategory,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }
}

class Fill {
  final String name;

  Fill({required this.name});
}
