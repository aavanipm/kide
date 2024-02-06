// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// class AnimalPage extends StatefulWidget {
//   @override
//   _AnimalPageState createState() => _AnimalPageState();
// }
//
// class _AnimalPageState extends State<AnimalPage> {
//   FlutterTts flutterTts = FlutterTts();
//
//   void speakAnimalName(String animalName) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(animalName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animal Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/dog.png', height: 200, width: 200),
//             SizedBox(height: 20),
//             Text(
//               'Lion',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 speakAnimalName('Dog');
//               },
//               child: Text('Speak Animal Name'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }