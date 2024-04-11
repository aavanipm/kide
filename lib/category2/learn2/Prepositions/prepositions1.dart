import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Preposition1 extends StatefulWidget {
  Preposition1({Key? key});

  @override
  State<Preposition1> createState() => _Preposition1State();
}

class _Preposition1State extends State<Preposition1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prepositions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: Swiper(
        itemCount: 4,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return PrepositionIntroductionPage();
            case 1:
              return PrepositionDefinitionPage();
            case 2:
              return PrepositionExamplesPage();
            case 3:
              return PrepositionTypesPage();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class PrepositionIntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🌟 Let's Learn Prepositions! 🌟",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrepositionDefinitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "What are ",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  "PREPOSITIONS",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  "?",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Prepositions are words that indicate the relationship between a noun or pronoun and other words in a sentence. They often show location, direction, time, or possession.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class PrepositionExamplesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
          children: [
            SizedBox(height: 20),
            Text(
               "Examples of Prepositions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            Expanded(
              child: Swiper(
                itemCount: 12,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("in: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The cat is in the box.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 90,),
                          Image.asset("assets/learning/grammar/learn/catbox.png", height: 300, width: 300,),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("on: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The book is on the table.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/tablebook.png", height: 250, width: 250,),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("at: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("We will meet at the park.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("for: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("This book is for reading.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ],
                      );
                    case 4:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("to: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("I went to the store.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/store.png", width: 250, height: 250,),
                        ],
                      );

                    case 5:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("over: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The bird flew over the tree.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/birdtree.png", width: 250, height: 250,)
                        ],
                      );
                    case 6:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("above: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The stars are above us.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/starsky.png", height: 250, width: 250,),
                        ],
                      );
                    case 7:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("below: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The fish is below the water.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 110,),
                          Image.asset("assets/learning/grammar/learn/fish.png", height: 250, width: 250,),
                        ],
                      );
                    case 8:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("under: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The dog is under the bed.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/dogcot.png", width: 250, height: 250,)
                        ],
                      );
                    case 9:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("between: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The ball is between the two trees.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/balltree.png", width: 250, height: 250,)
                        ],
                      );

                    case 10:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("by: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("He arrived by bus.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 140,),
                          Image.asset("assets/learning/grammar/learn/busboy.png", width: 250, height: 250,)
                        ],
                      );
                    case 11:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("across: ", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                              Text("The bridge goes across the river.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 140,),
                          Image.asset("assets/learning/grammar/learn/bridge.png", width: 250, height: 250,)
                        ],
                      );
                    default:
                      return Container();
                  }
                },
                pagination: SwiperPagination(),
                control: SwiperControl(), // Add control for navigation icons
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrepositionTypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Types of Prepositions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Text(
              "1. Prepositions of Place:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "Prepositions that show where something is located. For example: in, on, at, under, over, beside, between, among.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "2. Prepositions of Time:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "Prepositions that show when something happens. For example: before, after, during, at, on, in.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "3. Prepositions of Movement:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "Prepositions that show how something moves. For example: to, from, into, onto, out of, across, through.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

