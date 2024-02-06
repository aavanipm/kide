import 'package:flutter/material.dart';
import 'package:game/category2/game2/game2.dart';
import 'package:game/category2/learn2/learn2.dart';

class Home2 extends StatefulWidget {
  final String username;
  final String email;
  const Home2({super.key, required this.username, required this.email});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"), backgroundColor: Colors.blue.shade100,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Learn2()));
                },
                child: Column(
                  children: [
                    Image.asset("assets/home/learn2.png", fit: BoxFit.contain, height: 150, width: 150,),
                    Text("Learn", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              SizedBox(width: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Game2()));
                },
                child: Column(
                  children: [
                    Image.asset("assets/home/games2.png", fit: BoxFit.contain, height: 150, width: 150,),
                    Text("Games", style: TextStyle(fontSize: 20),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
