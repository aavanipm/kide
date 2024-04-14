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
        itemCount: 5, // Changed itemCount to 4
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return NounIntroductionPage();
            case 1:
              return NounDefinitionPage();
            case 2:
              return NounTypesDefinitionPage();
            case 3:
              return NounFunFactsPage();
            case 4:
              return NounUsagePage();
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
                                style: TextStyle(fontSize: 20.0, color: Colors.brown),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Image.asset("assets/learning/grammar/learn/booktoy.png", height: 250, width: 250,),
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
                                style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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

class NounFunFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: SingleChildScrollView(
        child: Padding(
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
                "1. Common Nouns:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Common nouns are general names for people, places, things, or ideas. Examples include 'teacher,' 'city,' and 'happiness.'",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                "2. Proper Nouns:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Proper nouns are specific names for individual people, places, organizations, or things. They always begin with a capital letter. Examples include 'John,' 'Paris,' and 'Eiffel Tower.'",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                "3. Abstract Nouns:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Abstract nouns represent ideas, qualities, or feelings that cannot be seen or touched. Examples include 'love,' 'courage,' and 'happiness.'",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                "4. Singular and Plural Nouns:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Nouns can be singular (referring to one person, place, thing, or idea) or plural (referring to more than one).",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                "5. Capitalization of Proper Nouns:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Proper nouns always begin with a capital letter. They name specific people, places, or things.",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                "Learning about nouns can help you become a better writer and communicator!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
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
              SizedBox(height: 5),
              Text(
                "Sarah (proper noun) went to the beach (common noun) and built a sandcastle (common noun) while feeling joy (abstract noun).",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 100), // Added extra space at the bottom for scrolling
            ],
          ),
        ),
      ),
    );
  }
}


class NounUsagePage extends StatelessWidget {
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
              "Using Nouns in Sentences",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Nouns are essential building blocks in constructing sentences. They can serve as subjects, objects, or complements in a sentence.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Here are some examples:",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Text("1. Subject: Sarah loves to read books.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left,
            ),
            SizedBox(height: 40,),
            Text("2. Object: She bought a new car.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40,),
            Text("3. Complement: Happiness is contagious.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),

          ],
        ),
      ),
    );
  }
}

class NounTypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noun Types Examples'),
        backgroundColor: Colors.purple.shade100,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Examples of Different Types of Nouns in Sentences",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Let's explore examples of various types of nouns used in sentences to deepen our understanding.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Here are some examples:",
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
                          Text(
                            "1. Sarah went to the park with her dog.",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "In this sentence, 'Sarah' is a proper noun, 'park' is a common noun, and 'dog' is a common noun.",
                            style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Text(
                            "2. The Eiffel Tower is a famous landmark in Paris.",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "In this sentence, 'Eiffel Tower' is a proper noun, 'landmark' is a common noun, and 'Paris' is a proper noun.",
                            style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Text(
                            "3. My grandmother gave me a beautiful necklace for my birthday.",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "In this sentence, 'grandmother' is a common noun, 'necklace' is a common noun, and 'birthday' is a common noun.",
                            style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Text(
                            "4. The concept of time is fascinating.",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "In this sentence, 'concept' is a common noun and 'time' is a common noun.",
                            style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      );
                    default:
                      return Container();
                  }
                },
                pagination: SwiperPagination(),
                control: SwiperControl(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

