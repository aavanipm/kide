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
        itemCount: 7,
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
            case 4:
              return AdjectiveExample3();
            case 5:
              return AdjectiveExample4();
            case 6:
              return AdjectiveExample5();
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
            SizedBox(height: 20,),
            Text("The red apple.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
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
            SizedBox(height: 20,),
            Text("The large elephant.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Add these classes along with the existing ones

class AdjectiveExample3 extends StatelessWidget {
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
                Text("Comparative Form: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("bigger",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("The bigger balloon.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class AdjectiveExample4 extends StatelessWidget {
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
                Text("Demonstrative Form: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("this",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("This beautiful flower.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
class AdjectiveExample5 extends StatelessWidget {
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
                Text("Possessive Form: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text("my",
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("My favorite toy.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
