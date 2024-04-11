import 'package:flutter/material.dart';
import 'package:game/category1/game1/fillblanks/Fills.dart';
import 'package:game/category1/game1/guess/levelguess.dart';
import 'package:game/category2/game2/noun.dart';

class Game2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  Game2({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Game2> createState() => _Game2State();
  List<Games> values = [
    Games(imagepath: "assets/game/fill.png", name: "Noun"),
    // Games(imagepath: "assets/game/guess.png", name: "Guess"),
  ];
}

class _Game2State extends State<Game2> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: widget.values.length, // Accessing values through widget
          itemBuilder: (context, index) {
            return gamecard(context, widget.values[index], widget.username, widget.email, widget.age, widget.subscribedCategory);
          },
        ),
      ),
    );
  }
}

Widget gamecard(BuildContext context, Games val, String username, String email, String age, String subscribedCategory) {
  return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'Noun':
            Navigator.push(context, MaterialPageRoute(builder: (context) => NounQuestionsPage(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Guess':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelGuess(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.asset(val.imagepath, height: 150, width: 150,),
            // Text(val.name)
          ],
        ),
      )
  );
}

class Games{
  final String imagepath;
  final String name;

  Games({required this.imagepath, required this.name});
}
