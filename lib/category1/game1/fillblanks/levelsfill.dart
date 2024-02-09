import 'package:flutter/material.dart';
import 'package:game/category1/game1/fillblanks/fill1.dart';
import 'package:game/category1/game1/fillblanks/fill2.dart';
import 'package:game/category1/game1/fillblanks/fill3.dart';

class LevelFill extends StatefulWidget {
  const LevelFill({super.key});

  @override
  State<LevelFill> createState() => _LevelFillState();
}

class _LevelFillState extends State<LevelFill> {
  List<Fill> values = [
    Fill(name: "1"),
    Fill(name: "2"),
    Fill(name: "3"),
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
  Widget fillcard(BuildContext context,Fill val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case '1':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Fill1()));
            break;

          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Fill2()));
            break;

          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Fill3()));

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

class Fill{
  final String name;

  Fill({required this.name});
}
