import 'package:flutter/material.dart';
import 'package:game/category1/game1/Scramble/Scramble2.dart';
import 'package:game/category1/game1/Scramble/Scramble3.dart';
import 'package:game/category1/game1/Scramble/Scramble5.dart';
import 'package:game/category1/game1/Scramble/Scramble6.dart';
import 'package:game/category1/game1/Scramble/Scramble7.dart';
import 'package:game/category1/game1/Scramble/scarmble1.dart';
import 'package:game/category1/game1/Scramble/scramble%20demo.dart';
import 'package:game/category1/game1/Scramble/scramble4.dart';
import 'package:game/category1/game1/Scramble/scrambles.dart';
import 'package:game/category1/game1/scramblecat3.dart';

class Scramblelevel extends StatefulWidget {
  const Scramblelevel({super.key});

  @override
  State<Scramblelevel> createState() => _ScramblelevelState();
}

class _ScramblelevelState extends State<Scramblelevel> {
  List<Scrambled> values = [

    Scrambled(name: "ANIMALS"),
    Scrambled(name: "BIRDS"),
    Scrambled(name: "FRUITS"),
    Scrambled(name: "FLOWERS"),
    Scrambled(name: "COLOURS"),
    Scrambled(name: "NUMBERS"),
    Scrambled(name: "VEGETABLES"),
    Scrambled(name: "8"),
    Scrambled(name: "9"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"), backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: values.length,
            itemBuilder: (context, index){
              return levelcard(context, values[index]);
            }
        ),
      ),
    );

  }
  Widget levelcard(BuildContext context,Scrambled val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'ANIMALS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble1()));
            break;

          case 'BIRDS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble2()));
            break;

          case 'FRUITS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble3()));
            break;

          case 'FLOWERS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble4()));
            break;

          case 'COLOURS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble5()));
            break;

          case 'NUMBERS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble6()));
            break;

          case 'VEGETABLES':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble7()));
            break;

          case '8':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ScramblePage()));
            break;

          case '9':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramblecat3()));
            break;

          // case '10':
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>))

            default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(val.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
          ),
        ),
      ),
    );
  }
}

class Scrambled{
  final String name;

  Scrambled({required this.name});
}
