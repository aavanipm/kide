import 'package:flutter/material.dart';
import 'package:game/category2/game2/game2.dart';

class Game3 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Game3({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory
  }) : super(key: key);
  @override
  State<Game3> createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}
