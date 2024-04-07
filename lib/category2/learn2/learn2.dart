import 'package:flutter/material.dart';
import 'package:game/category2/learn2/grammer.dart';
import 'package:game/category2/learn2/learnnames.dart';

class Learn2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Learn2({super.key, required this.username, required this.email, required this.age, required this.subscribedCategory});

  @override
  State<Learn2> createState() => _Learn2State();
}

class _Learn2State extends State<Learn2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Learn"), backgroundColor: Colors.blue.shade100,
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Grammar()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/learning/grammar/grammar2.png", height: 250, width: 300,),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LearnNames()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/learning/grammar/names2.png", height: 250, width: 300,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
