import 'package:flutter/material.dart';
import 'package:game/category3/learn3/learn3.dart';

class Learn3 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Learn3({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory
  }) : super(key: key);

  @override
  State<Learn3> createState() => _Learn3State();
}

class _Learn3State extends State<Learn3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}
