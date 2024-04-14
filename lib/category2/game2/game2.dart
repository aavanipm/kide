import 'package:flutter/material.dart';
import 'package:game/category2/game2/adjective.dart';
import 'package:game/category2/game2/adverb.dart';
import 'package:game/category2/game2/noun.dart';
import 'package:game/category2/game2/preposistion.dart';
import 'package:game/category2/game2/pronoun.dart';
import 'package:game/category2/game2/verb.dart';

class Game2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  Game2({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Game2> createState() => _Game2State();
  List<Games> values = [
    Games(imagepath: "assets/learning/grammar/noungame.png", name: "Noun"),
    Games(imagepath: "assets/learning/grammar/verbgame.png", name: "Verb"),
    Games(imagepath: "assets/learning/grammar/adjgame.png", name: "Adjective"),
    Games(imagepath: "assets/learning/grammar/pregame.png", name: "Preposition"),
    Games(imagepath: "assets/learning/grammar/adverbgame.png", name: "Adverb"),
    Games(imagepath: "assets/learning/grammar/pronoungame.png", name: "Pronoun"),
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

          case 'Verb':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VerbQuestionsPage(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Adverb':
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdverbQuestionsPage(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Adjective':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdjectiveQuestionsPage(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Pronoun':
            Navigator.push(context, MaterialPageRoute(builder: (context) => PronounQuestionsPage(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Preposition':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PrepositionQuestionsPage(
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
            Text(val.name),
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
