import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Pronoun1 extends StatefulWidget {
  Pronoun1({Key? key}) : super(key: key);

  @override
  State<Pronoun1> createState() => _Pronoun1State();
}

class _Pronoun1State extends State<Pronoun1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pronouns",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Swiper(
        itemCount: 6,
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return PronounIntroductionPage();
            case 1:
              return PronounDefinitionPage();
            case 2:
              return PronounType1();
            case 3:
              return PronounType2();
            case 4:
              return PronounType3();
            case 5:
              return PronounType4();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class PronounIntroductionPage extends StatelessWidget {
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
                "🌟 Let's Learn Pronouns! 🌟",
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

class PronounDefinitionPage extends StatelessWidget {
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
                  "PRONOUNS",
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
              "Pronouns are words that are used in place of nouns to avoid repetition.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 50),
            Text(
              "Pronouns can be categorized into different types based on their usage.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class PronounType1 extends StatelessWidget {
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
              "Personal Pronouns:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Expanded(
              child: Swiper(
                itemCount: 7,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "I: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "I am happy.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/happy.png", height: 250, width: 250,),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "You: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "You are smart.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/smart.png", height: 250, width: 250,),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "He: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "He is playing.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/boyplay.png", height: 250, width: 250,),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "She: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "She is singing.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ]
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/girlsing.png", height: 250, width: 250,),
                        ],
                      );
                    case 4:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "We: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "We are learning.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/threelearn.png", height: 250, width: 250,),
                        ],
                      );
                    case 5:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "They: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "They are friends.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/friends.png", height: 250, width: 250,),
                        ],
                      );
                    case 6:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "It: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "It is a cat.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 150,),
                          Image.asset("assets/learning/grammar/learn/cat.png", height: 250, width: 250,),
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

class PronounType2 extends StatelessWidget {
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
              "Possessive Pronouns:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Expanded(
              child: Swiper(
                itemCount: 7,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mine: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "This book is mine.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 130,),
                          Image.asset("assets/learning/grammar/learn/mine.png", height: 250, width: 250,),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Yours: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "The red hat is mine,",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    " and the blue one is yours.",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 100,),
                          Image.asset("assets/learning/grammar/learn/hat.png", height: 250, width: 250,),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "His: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "David has a new phone.",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    " His camera is amazing.",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 100,),
                          Image.asset("assets/learning/grammar/learn/phone.png", height: 250, width: 250,),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Her: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  SizedBox(width: 5,),
                                  Text(
                                    "Sarah baked a delicious cake. ",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Her frosting is the best!",
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 90,),
                          Image.asset("assets/learning/grammar/learn/cake.png", height: 300, width: 300,),
                        ],
                      );
                    case 4:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "its: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "The cat is licking its paw.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/catlick.png", height: 250, width: 250,),
                        ],
                      );
                    case 5:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ours: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "The house is ours.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 120,),
                          Image.asset("assets/learning/grammar/learn/home.png", height: 250, width: 250,),
                        ],
                      );
                    case 6:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Theirs: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "The bikes are theirs.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 100,),
                          Image.asset("assets/learning/grammar/learn/bikes.png", height: 250, width: 250,),
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

class PronounType3 extends StatelessWidget {
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
              "Demonstrative Pronouns:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
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
                                "This: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "This book is interesting.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 110,),
                          Image.asset("assets/learning/grammar/learn/newbook.png", height: 250, width: 250,),
                        ],
                      );
                    case 1:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "That: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "That dog is barking loudly.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 110,),
                          Image.asset("assets/learning/grammar/learn/dogbark.png", height: 250, width: 250,),
                        ],
                      );
                    case 2:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "These: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "These cookies are my favorite.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 100,),
                          Image.asset("assets/learning/grammar/learn/cookie.png", height: 250, width: 250,),
                        ],
                      );
                    case 3:
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Those: ",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Those flowers smell wonderful.",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400 ),
                              ),
                            ],
                          ),
                          SizedBox(height: 110,),
                          Image.asset("assets/learning/grammar/learn/flowers.png", height: 250, width: 250,),
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

class PronounType4 extends StatelessWidget {
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
              "Interrogative Pronouns:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            Text("Who: ",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            Text("Who is coming to the party tonight?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400 ),
            ),
            SizedBox(height: 20,),
            Text("Whom: ",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            Text("Whom did you invite to the event?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400 ),
            ),
            SizedBox(height: 20,),

            Text("Whose: ",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            Text("Whose book is this on the table?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400 ),
            ),
            SizedBox(height: 20,),

            Text("Which: ",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            Text("Which dress should I wear to the party?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400 ),
            ),
            SizedBox(height: 20,),
            Text("What: ",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Text("What is your favorite color?",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400 ),
            ),
          ],
        ),
      ),
    );
  }
}
