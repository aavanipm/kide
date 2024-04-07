import 'package:flutter/material.dart';

class Game2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Game2({super.key, required this.username, required this.email, required this.age, required this.subscribedCategory});

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
    );
  }
}
