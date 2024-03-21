import 'package:flutter/material.dart';
import 'package:game/category1/game1/fillblanks/AnimalLevels/levelsfill.dart';
import 'package:game/category1/game1/fillblanks/BirdLevels/BirdLevel.dart';
import 'package:game/category1/game1/fillblanks/FruitLevels/FruitLEvel.dart';
import 'package:game/category1/game1/fillblanks/VegetableLevels/Vegelevel.dart';
import 'package:game/category3/learn3/Story/Story2.dart';
import 'package:game/category3/learn3/Story/Story3.dart';

class Fills extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const Fills({Key? key, required this.username, required this.email, required this.age}) : super(key: key);

  @override
  State<Fills> createState() => _FillsState();
}

class _FillsState extends State<Fills> {
  List<Fill> values = [
    Fill(name: "ANIMALS"),
    Fill(name: "BIRDS"),
    Fill(name: "FRUITS"),
    Fill(name: "VEGETABLES"),
    Fill(name: "NUMBERS"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FILL IN THE BLANKS"),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 6),

          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (context, index){
            return learncard(context, values[index]);
          }
      ),
    );
  }
  Widget learncard(BuildContext context, Fill val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'ANIMALS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelFill(
                username: widget.username, email: widget.email, age: widget.age)));
            break;
          case 'BIRDS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BirdLevel(
                username: widget.username, email: widget.email, age: widget.age)));
            break;
          case 'FRUITS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FruitLevel(
                username: widget.username, email: widget.email, age: widget.age)));
            break;
          case 'VEGETABLES':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VegeLevel(
                username: widget.username, email: widget.email, age: widget.age)));
            break;
          case 'Story2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondStory()));
            break;
          case 'Story3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdStory()));
            break;
          default:
            break;
        }
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              val.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
            )
          ],
        ),
      ),

    );
  }
}

class Fill{
  final String name;

  Fill({required this.name});
}