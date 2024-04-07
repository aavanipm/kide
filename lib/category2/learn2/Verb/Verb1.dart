import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Verb1 extends StatelessWidget {
  const Verb1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verbs"),
        backgroundColor: Colors.lightGreen.shade200,
      ),
      body: Swiper(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            switch(index) {
              case 0:
                return VerbIntroduction();
              case 1:
                return VerbDefinition();
              case 2:
                return VerbExample1();
              case 3:
                return VerbExample2();
              case 4:
                return VerbExample3();
              case 5:
                return VerbExample4();
              default:
                return Container();
            }
          },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class VerbIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: Center(
        child: Text(
          "🌟 Let's Learn Verbs! 🌟",
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class VerbDefinition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
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
                  "VERBS",
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
              "Verbs are action words that tell us what someone or something is doing!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              "For example, think about what you do: run, jump, play, laugh!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              "Verbs make our sentences exciting and full of action!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class VerbExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text(
                  "Here are some examples",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 40,),
                Text(
                  "Run: I run fast.",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Image.asset(
            "assets/learning/grammar/learn/boyrun.png",
            width: 250,
            height: 250,
          ),
        ],
      ),
    );
  }
}

class VerbExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Center(
            child: Text(
              "Jump: The rabbit jumps high.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Image.asset("assets/learning/grammar/learn/rabbitjumb.png", width: 250, height: 250,),
        ],
      ),
    );
  }
}

class VerbExample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Center(
            child: Text(
              "Play: We play in the park.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Image.asset("assets/learning/grammar/learn/park.png", width: 250, height: 250,),
        ],
      ),
    );
  }
}

class VerbExample4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Center(
            child: Text(
              "Laugh: She laughs when she's happy.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Image.asset("assets/learning/grammar/learn/girllaugh.png", width: 250, height: 250,),
        ],
      ),
    );
  }
}
