// import 'package:flutter/material.dart';
//
// class Noun1 extends StatelessWidget {
//   const Noun1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "🌟 Let's Explore Nouns! 🌟",
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Hello!",
//               style: TextStyle(
//                 fontSize: 32.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepOrange,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Nouns are special words that name people, places, things, or ideas.",
//               style: TextStyle(fontSize: 24.0, color: Colors.blue),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "For example, think about things you see: dog, school, ball, love!",
//               style: TextStyle(fontSize: 24.0, color: Colors.green),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Nouns help us talk about the world around us and express our thoughts and feelings!",
//               style: TextStyle(fontSize: 24.0, color: Colors.deepOrange),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Here are some examples of nouns:",
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               "1. Person: Sarah, teacher",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "2. Place: park, beach",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "3. Thing: book, toy",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "4. Idea: happiness, friendship",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Noun1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouns", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Swiper(
        itemCount: 5,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return NounIntroductionPage();
            case 1:
              return NounDefinitionPage();
            case 2:
              return NounExamplePage();
            case 3:
              return NounTypesDefinitionPage();
            case 4:
              return NounTypesExamplePage();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class NounIntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🌟 Let's Learn Nouns! 🌟",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NounDefinitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("What are ",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                ),
                Text("NOUNS",
                  style: TextStyle(fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlue,
                  ),
                ),
                Text("?",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              "Nouns are words used to name people, places, things, or ideas.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Here are some examples of nouns...",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(" - Sarah", style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 10,),
                Text(" - School", style: TextStyle(
                  fontSize: 20,),
                ),
                SizedBox(height: 10,),
                Text(" - Cat", style: TextStyle(
                  fontSize: 20),
                ),
                SizedBox(height: 10,),
                Text(" - Happiness", style: TextStyle(
                  fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NounExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Here are some examples of nouns:",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              "Sarah, school, book, table, cat, happiness",
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NounTypesDefinitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Types of Nouns",),
          Text(
              "Nouns can be categorized into different types based on what they name.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NounTypesExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Examples of Noun Types",),
            Text(
              "Here are examples of different types of nouns:",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              "Person: Sarah, teacher, doctor\nPlace: park, beach, school\nThing: book, toy, car\nIdea: happiness, courage",
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
