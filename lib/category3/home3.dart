import 'package:flutter/material.dart';
import 'package:game/category3/learn3/learn3.dart';

class Home3 extends StatefulWidget {
  final String username;
  final String email;
  const Home3({super.key, required this.username, required this.email});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"), backgroundColor: Colors.blue.shade100,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Learn3()));
                },
                child: Column(

                  children: [
                    Image.asset("assets/home/learn3.png", height: 150, width: 150, fit: BoxFit.contain,),
                    Text("Learn", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Column(
                children: [
                  Image.asset("assets/home/games3.png", fit: BoxFit.contain, height: 150, width: 150,),
                  Text("Games", style: TextStyle(fontSize: 20),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
