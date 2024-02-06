import 'package:flutter/material.dart';

class Flowers extends StatefulWidget {
  const Flowers({super.key});

  @override
  State<Flowers> createState() => _FlowersState();
}

class _FlowersState extends State<Flowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flowers"),
      ),
    );
  }
}
