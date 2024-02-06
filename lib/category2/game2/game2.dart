import 'package:flutter/material.dart';
import 'package:game/category2/game2/identify.dart';

class Game2 extends StatefulWidget {
  const Game2({super.key});

  @override
  State<Game2> createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Identify()));
            },
            child: Column(
              children: [
                Image.asset("assets/images/img1.png", height: 150, width: 150,),
                Text("Identify"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
