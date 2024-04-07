import 'package:flutter/material.dart';
import 'package:game/category1/game1/Scramble/Scramble2.dart';
import 'package:game/category1/game1/Scramble/Scramble3.dart';
import 'package:game/category1/game1/Scramble/Scramble5.dart';
import 'package:game/category1/game1/Scramble/Scramble6.dart';
import 'package:game/category1/game1/Scramble/Scramble7.dart';
import 'package:game/category1/game1/Scramble/scarmble1.dart';
import 'package:game/category1/game1/Scramble/scramble4.dart';
import 'package:game/category1/game1/Scramble/scrambles.dart';
import 'package:game/category1/home1.dart';

class ScrambleLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const ScrambleLevel(
      {Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}
      ) : super(key: key);

  @override
  State<ScrambleLevel> createState() => _ScrambleLevelState();
}

class _ScrambleLevelState extends State<ScrambleLevel> {
  List<Scrambled> values = [

    Scrambled(name: "ANIMALS"),
    Scrambled(name: "BIRDS"),
    Scrambled(name: "FRUITS"),
    Scrambled(name: "FLOWERS"),
    Scrambled(name: "COLOURS"),
    Scrambled(name: "NUMBERS"),
    Scrambled(name: "VEGETABLES"),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble1(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'BIRDS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble2(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'FRUITS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble3(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'FLOWERS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble4(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'COLOURS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble5(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'NUMBERS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble6(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case 'VEGETABLES':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scramble7(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '9':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Scrambles()));
            break;

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
