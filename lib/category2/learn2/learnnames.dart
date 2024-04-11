import 'package:flutter/material.dart';
import 'package:game/learn/Alphabets.dart';
import 'package:game/learn/Colours.dart';
import 'package:game/learn/Fruits.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn/Vegetables.dart';
import 'package:game/learn/animals.dart';
import 'package:game/learn/birds.dart';
import 'package:game/learn/flowers.dart';

class LearnNames extends StatefulWidget {
  const LearnNames({super.key});

  @override
  State<LearnNames> createState() => _LearnNamesState();
}

class _LearnNamesState extends State<LearnNames> {
  List<nameimage> values = [
    nameimage(imagepath: "assets/learning/alphabets.png", name: "Alphabets"),
    nameimage(imagepath: "assets/learning/animals.png", name: "Animals"),
    nameimage(imagepath: "assets/learning/birds.png", name: "Birds"),
    nameimage(imagepath: "assets/learning/fruits.png", name: "Fruits"),
    nameimage(imagepath: "assets/learning/numbers.png", name: "Numbers"),
    nameimage(imagepath: "assets/learning/colours.png", name: "Colours"),
    nameimage(imagepath: "assets/learning/flowers.png", name: "Flowers"),
    nameimage(imagepath: "assets/learning/vegetables.png", name: "Vegetables"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.blue.shade50,
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

          case 'Alphabets':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Alphabets()));
            break;

          case 'Animals':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Animals()));
            break;

          case 'Birds':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Birds()));
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
            break;

          case 'Vegetables':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Vegetables()));
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
