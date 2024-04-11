import 'package:flutter/material.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence2.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence3.dart';
import 'package:game/category1/game1/sentencecompletion/sentence1.dart';
import 'package:game/category1/game1/sentencecompletion/sentencecomplete.dart';

class SentenceLevels extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SentenceLevels({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<SentenceLevels> createState() => _SentenceLevelsState();
}

class _SentenceLevelsState extends State<SentenceLevels> {
  List<Sentences> values = [
    Sentences(name: "1"),
    Sentences(name: "2"),
    Sentences(name: "3"),
    // Sentences(name: "4"),
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
  Widget levelcard(BuildContext context,Sentences val){
    return GestureDetector(
      onTap: (){
        switch(val.name){
          case '1':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sentence1(
                username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sentence2(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sentence3(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            )));
            break;

          // case '4':
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SentenceCompletionScreen()));
          //   break;


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

class Sentences{
  final String name;

  Sentences({required this.name});
}
