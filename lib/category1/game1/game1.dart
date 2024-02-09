import 'package:flutter/material.dart';
import 'package:game/category1/game1/fillblanks/filldemo.dart';
import 'package:game/category1/game1/guess/levelsection.dart';
import 'package:game/category1/game1/match/match.dart';
import 'package:game/category1/game1/scramble.dart';
import 'package:game/category1/game1/scramble3.dart';
import 'package:game/category1/game1/speak/guessandspeak.dart';



class Game1 extends StatefulWidget {
  Game1({super.key});

  @override
  State<Game1> createState() => _Game1State();
  List<Games> values = [
    Games(imagepath: "assets/images/img1.png", name: "Fill"),
    Games(imagepath: "assets/images/img1.png", name: "Guess"),
    Games(imagepath: "assets/images/img1.png", name: "Match"),
    Games(imagepath: "assets/images/img1.png", name: "Speak"),
    Games(imagepath: "assets/images/img1.png", name: "scramble"),
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
            return gamecard(context, widget.values[index]); // Adjusted function call
          },
        ),
      ),
    );
  }
}

Widget gamecard(BuildContext context, Games val){
  return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'Fill':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FillName()));
            break;

          case 'Guess':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelSelection()));
            break;

          case 'Match':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Match()));
            break;

          case 'Speak':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble3()));
            break;

          case 'scramble':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scrambleone()));

          default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.asset(val.imagepath, height: 150, width: 150,),
            Text(val.name)
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
