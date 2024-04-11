import 'package:flutter/material.dart';
import 'package:game/category2/learn2/Adjective/adjective1.dart';
import 'package:game/category2/learn2/Noun/Noun1.dart';
import 'package:game/category2/learn2/Prepositions/prepositions1.dart';
import 'package:game/category2/learn2/Pronoun/pronoun1.dart';
import 'package:game/category2/learn2/Verb/Verb1.dart';

class Grammar extends StatefulWidget {
  const Grammar({Key? key}) : super(key: key);

  @override
  State<Grammar> createState() => _GrammarState();
}

class _GrammarState extends State<Grammar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grammar Page"),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              GestureDetector(
                child: Image.asset("assets/learning/grammar/noun2.png",
                  height: 200,
                  width: 300,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Noun1()));
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Image.asset("assets/learning/grammar/verb2.png",
                  height: 200,
                  width: 300,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Verb1()));
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Image.asset("assets/learning/grammar/adjective2.png",
                  height: 200,
                  width: 300,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Adjective1()));
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Image.asset("assets/learning/grammar/prepositions.png",
                  height: 200,
                  width: 300,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Preposition1()));
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Image.asset("assets/learning/grammar/pronoun.png",
                  height: 200,
                  width: 300,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Pronoun1()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
