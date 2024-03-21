import 'package:flutter/material.dart';
import 'package:game/category2/learn2/Adjective/adjective1.dart';
import 'package:game/category2/learn2/Noun/Noun1.dart';
import 'package:game/category2/learn2/Verb/Verb1.dart';
import 'package:game/category3/learn3/Story/Story1.dart';
import 'package:game/category3/learn3/Story/Story2.dart';
import 'package:game/category3/learn3/Story/Story3.dart';

class Learn2 extends StatefulWidget {
  const Learn2({super.key});

  @override
  State<Learn2> createState() => _Learn2State();
}

class _Learn2State extends State<Learn2> {
  List<Learn> values = [
    Learn(name: "NOUN"),
    Learn(name: "VERB"),
    Learn(name: "ADJECTIVE"),
    Learn(name: "Story"),
    Learn(name: "Story1"),
    Learn(name: "Story3"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grammer"),
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
  Widget learncard(BuildContext context, Learn val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case 'NOUN':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Noun1()));
            break;
          case 'VERB':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Verb1()));
            break;
          case 'ADJECTIVE':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Adjective1()));
            break;
          case 'Story1':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstStory()));
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

class Learn{
  final String name;

  Learn({required this.name});
}