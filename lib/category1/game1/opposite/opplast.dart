import 'package:flutter/material.dart';
import 'package:game/category1/home1.dart';

class OppoLast extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const OppoLast({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);
  @override
  State<OppoLast> createState() => _OppoLastState();
}

class _OppoLastState extends State<OppoLast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Game Completed :)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home1(
                      username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory
                  )));
                }, child: Text("Go To Home")
            ),
          ],
        ),
      ),
    );
  }
}
