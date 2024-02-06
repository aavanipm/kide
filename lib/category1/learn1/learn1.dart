import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game/learn/Colours.dart';
import 'package:game/learn/Fruits.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn/animals.dart';
import 'package:game/learn/flowers.dart';

class Learn1 extends StatefulWidget {
  const Learn1({super.key});

  @override
  State<Learn1> createState() => _Learn1State();
}

class _Learn1State extends State<Learn1> {
  List<nameimage> values = [
    nameimage(imagepath: "assets/learning/animals.png", name: "Animals"),
    nameimage(imagepath: "assets/learning/fruits.png", name: "Fruits"),
    nameimage(imagepath: "assets/learning/numbers.png", name: "Numbers"),
    nameimage(imagepath: "assets/learning/colours.png", name: "Colours"),
    nameimage(imagepath: "assets/learning/flowers.png", name: "Flowers")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 16, mainAxisSpacing: 16
        ),

            itemCount: values.length,
            itemBuilder: (context, index){
          return categorycard(context, values[index]);
            }),
      ),
    );
  }
}

Widget categorycard(BuildContext context, nameimage val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'Animals':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Animals()));
            break;

          case 'Fruits':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Fruits()));
            break;

          case 'Numbers':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Numbers()));
            break;

          case 'Colours':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Colours()));
            break;

          case 'Flowers':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Flowers()));

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
class nameimage{
  final String imagepath;
  final String name;

  nameimage({required this.imagepath, required this.name});
}