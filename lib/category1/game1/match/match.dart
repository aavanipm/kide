import 'package:flutter/material.dart';
import 'package:game/category1/game1/match/match1.dart';
import 'package:game/category1/game1/match/match2.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  List<Matching> values = [
    Matching(name: "1"),
    Matching(name: "2")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"), backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemCount: values.length,
            itemBuilder: (context, index){
          return levelcard(context, values[index]);
            }
        ),
      ),
    );

  }
  Widget levelcard(BuildContext context,Matching val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case '1':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Match1()));
            break;

          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Match2()));
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

class Matching{
  final String name;

  Matching({required this.name});
}
