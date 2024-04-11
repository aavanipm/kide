import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Adjective1 extends StatelessWidget {
  const Adjective1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adjective"),
        backgroundColor: Colors.orange.shade100,
      ),
      body: Swiper(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          switch (index){
            case 0:
              return AdjectiveIntroduction();
            case 1:
              return AdjectiveDefinition();
            case 2:
              return AdjectiveExample1();
            case 3:
              return AdjectiveExample2();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class AdjectiveIntroduction extends StatelessWidget {
  const AdjectiveIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🌟 Let's Learn Adjective! 🌟",
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

class AdjectiveDefinition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
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
                  "ADJECTIVES",
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
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Adjectives are describing words that tell us more about nouns.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adjectives can answer questions like ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        " 'What kind?' ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        " 'Which one?'",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        " 'How many?'",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Adjectives can be used before or after the noun they describe, depending on the sentence structure.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdjectiveExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Color: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("red, ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                ),
                Text("blue, ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.blue),
                ),
                Text("green",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text("The red apple.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Image.asset("assets/learning/grammar/learn/bigapple.png", height: 110, width: 110,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Size: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("tiny, ",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                Text("small, ",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
                Text("big",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text("The large elephant.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Image.asset("assets/learning/grammar/learn/bigelephant.png", height: 110, width: 110,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Shape: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("round , ",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                Text("square , ",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
                Text("oval ",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text("The square box.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Image.asset("assets/learning/grammar/learn/squarebox.png", width: 110, height: 110,),
          ],
        ),
      ),
    );
  }
}

class AdjectiveExample2 extends StatelessWidget {
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
            Text("Adjective Forms",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Swiper(
                itemCount: 5,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Positive Form: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "big",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "The house is big.", // Example sentence
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The positive form of an adjective is the simplest form and is used to describe a noun without comparison",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 40,),
                          Image.asset("assets/learning/grammar/learn/bighouse.png", height: 250, width: 250,),
                        ],
                      );

                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Comparative Form: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "bigger",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "The elephant is bigger than the mouse.", // Example sentence
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The comparative form of an adjective is used to compare two things. It typically ends with '-er' or uses the word 'more'. For example, 'bigger' is used to compare the size of two balloons.",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 40,),
                          Image.asset("assets/learning/grammar/learn/ratele.png", height: 250, width: 250,),
                        ],
                      );

                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Superlative Form: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "biggest",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Mount Everest is the highest mountain in the world.", // Example sentence
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The superlative form of an adjective is used to compare three or more things and shows the highest degree. It typically ends with '-es",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 40,),
                          Image.asset("assets/learning/grammar/learn/mounteverest.png", height: 250, width: 250,),
                        ],
                      );

                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Demonstrative Form: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "this",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "This beautiful flower.",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The demonstrative form of an adjective is used to indicate specific nouns that are near or close by. It helps us identify or point out things. For example, 'this' is used to talk about something close to us.",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 40,),
                          Image.asset("assets/learning/grammar/learn/redrose.png", height: 250, width: 250,),
                        ],
                      );

                    case 4:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Possessive Form: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "my",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "My favorite toy.",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The possessive form of an adjective shows ownership or possession. It tells us that something belongs to someone. For example, 'my' is used to show that the toy belongs to the speaker.",
                            style: TextStyle(fontSize: 18),
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
