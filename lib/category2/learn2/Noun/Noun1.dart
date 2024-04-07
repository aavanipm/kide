import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Noun1 extends StatefulWidget {
  Noun1({Key? key});

  @override
  State<Noun1> createState() => _Noun1State();
}

class _Noun1State extends State<Noun1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nouns",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Swiper(
        itemCount: 4, // Changed itemCount to 4
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return NounIntroductionPage();
            case 1:
              return NounDefinitionPage();
            case 2:
              return NounTypesDefinitionPage();
            case 3: // Additional page
              return NounFunFactsPage();
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
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🌟 Let's Learn Nouns! 🌟",
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

class NounDefinitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
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
                  "NOUNS",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlue,
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
              "Nouns are words used to name people, places, things, or ideas.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Here are some examples of nouns...",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(" - Sarah", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text(" - School", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text(" - Cat", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text(" - Happiness", style: TextStyle(fontSize: 20)),
              ],
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
          children: [
            SizedBox(height: 20),
            Text(
              "Types of Nouns",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Nouns can be categorized into different types based on what they name.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Examples of Noun Types",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Expanded(
              child: Swiper(
                itemCount: 4,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Person: ",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Sarah, Teacher",
                                style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Image.asset("assets/learning/grammar/learn/sara.png", height: 250, width: 250,),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Place: ",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "park, beach, school ",
                                style: TextStyle(fontSize: 20.0, color: Colors.lightBlueAccent),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Image.asset("assets/learning/grammar/learn/sea.png", height: 250, width: 250,),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Thing: ",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "book, toy, car",
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Idea: ",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "happiness, courage",
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Do you know?",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Nouns help us understand the world around us! They can be fun to learn and use in sentences.",
                            style: TextStyle(fontSize: 18.0),
                          ),
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

// Additional page for fun facts about nouns
class NounFunFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Fun Facts About Nouns",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "1. There are many types of nouns, including common nouns, proper nouns, and abstract nouns.",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "2. Nouns can be singular or plural. Singular nouns refer to one person, place, thing, or idea, while plural nouns refer to more than one.",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "3. Proper nouns always begin with a capital letter. They name specific people, places, or things.",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "4. Abstract nouns name ideas, qualities, or feelings that cannot be seen or touched, such as love, courage, or happiness.",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "5. Learning about nouns can help you become a better writer and communicator!",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Example:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "Sarah (proper noun) went to the beach (common noun) and built a sandcastle (common noun) while feeling joy (abstract noun).",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
