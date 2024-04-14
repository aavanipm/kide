import 'package:flutter/material.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';

class Guessandspeaklast extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Guessandspeaklast({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);
  @override
  State<Guessandspeaklast> createState() => _GuessandspeaklastState();
}

class _GuessandspeaklastState extends State<Guessandspeaklast> {
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
                  _navigate(widget.age);
                }, child: Text("Go To Home")
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigate(String age) async {
    int ageInt = int.tryParse(age) ?? 0; // Convert age to an integer

    if (ageInt == 2 || ageInt == 3 || ageInt == 4 || ageInt == 5) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home1(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory, // Update subscribed category
          ),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home2(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: widget.subscribedCategory, // Update subscribed category
          ),
        ),
      );
    }
  }
}
