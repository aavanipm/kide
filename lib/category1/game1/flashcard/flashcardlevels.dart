import 'package:flutter/material.dart';
import 'package:game/category1/game1/flashcard/FlashCard2.dart';
import 'package:game/category1/game1/flashcard/Flashcard1.dart';
import 'package:game/category1/game1/flashcard/Flashcard3.dart';
import 'package:game/category1/game1/flashcard/flashcard4.dart';
import 'package:game/category1/game1/flashcard/flashcard5.dart';
import 'package:game/category1/game1/flashcard/flashcard6.dart';
import 'package:game/category1/game1/flashcard/flashcard7.dart';

class FlashCardLevels extends StatefulWidget {
  const FlashCardLevels({super.key});

  @override
  State<FlashCardLevels> createState() => _FlashCardLevelsState();
}

class _FlashCardLevelsState extends State<FlashCardLevels> {
  List<FlashCard> values = [
    FlashCard(name: "1"),
    FlashCard(name: "2"),
    FlashCard(name: "3"),
    FlashCard(name: "4"),
    FlashCard(name: "5"),
    FlashCard(name: "6"),
    FlashCard(name: "7"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemCount: values.length,
            itemBuilder: (context, index){
              return fillcard(context, values[index]);
            }
        ),
      ),
    );
  }
  Widget fillcard(BuildContext context,FlashCard val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case '1':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard1()));
            break;

          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard2()));
            break;

          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard3()));
            break;

          case '4':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard4()));
            break;

          case '5':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard5()));
            break;

          case '6':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard6()));
            break;

          case '7':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashCard7()));
            break;

          default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(val.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashCard{
  final String name;

  FlashCard({required this.name});
}
