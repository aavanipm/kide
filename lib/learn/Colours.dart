import 'package:flutter/material.dart';

class Colours extends StatefulWidget {
  const Colours({super.key});

  @override
  State<Colours> createState() => _ColoursState();
}

class _ColoursState extends State<Colours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colours"),
      ),
    );
  }
}
