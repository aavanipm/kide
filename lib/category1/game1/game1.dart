import 'package:flutter/material.dart';
import 'package:game/category1/game1/Scramble/Scramblelevels.dart';
import 'package:game/category1/game1/fillblanks/Fills.dart';
import 'package:game/category1/game1/guess/levelguess.dart';
import 'package:game/category1/game1/match/match.dart';
import 'package:game/category1/game1/opposite/oppositelevels.dart';
import 'package:game/category1/game1/search/searchlevels.dart';
import 'package:game/category1/game1/sentencecompletion/Sentencelevels.dart';
import 'package:game/category1/game1/soundspell/SoundSpellLevel.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';
import 'package:game/category1/game1/synonym/Synonymlevels.dart';

class Game1 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  Game1({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Game1> createState() => _Game1State();
  List<Games> values = [
    Games(imagepath: "assets/game/fill.png", name: "Fill"),
    Games(imagepath: "assets/game/guess.png", name: "Guess"),
    Games(imagepath: "assets/game/match.png", name: "Match"),
    Games(imagepath: "assets/game/say.png", name: "Speak"),
    Games(imagepath: "assets/game/scramble.png", name: "scramble"),
    Games(imagepath: "assets/game/pair.png", name: "opposite"),
    Games(imagepath: "assets/game/synonym.png", name: "synonym"),
    Games(imagepath: "assets/game/spell.png", name: "flash"),
    Games(imagepath: "assets/game/sentence.png", name: "sentence"),
    Games(imagepath: "assets/game/word.png", name: "Search"),
    // Games(imagepath: "assets/images/img1.png", name: "SubDemo"),

    // Games(imagepath: "assets/images/img1.png", name: "past"),
  ];
}

class _Game1State extends State<Game1> {
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
          case 'Fill':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Fills(
                  username: username, email: email, age: age, subscribedCategory: subscribedCategory,
                ),
              ),
            );
            break;

          case 'Guess':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelGuess(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Match':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Match(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Speak':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessSpeakLevel(
                username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'scramble':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ScrambleLevel(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'opposite':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Oppositelevels(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'synonym':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Synonymlevels(
                username: username, email: email, age: age, subscribedCategory: subscribedCategory
            )));
            break;

          case 'flash':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoundSpellLevel(
              username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'sentence':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SentenceLevels(
                username: username, email: email, age: age, subscribedCategory: subscribedCategory,
            )));
            break;

          case 'Search':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchLevel()));
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
