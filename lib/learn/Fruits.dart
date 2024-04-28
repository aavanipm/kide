import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Fruits extends StatefulWidget {
  @override
  _FruitsState createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  FlutterTts flutterTts = FlutterTts();
  int currentFruitIndex = 0;
  bool autoPlayEnabled = false;
  List<Fruit> fruitList = [
    Fruit(name: "APPLE", image: "assets/Fruits/apple.png"),
    Fruit(name: "APRICOT", image: "assets/Fruits/apricot.png"),
    Fruit(name: "BANANA", image: "assets/Fruits/banana.png"),
    Fruit(name: "FIG", image: "assets/Fruits/fig.png"),
    Fruit(name: "GRAPE", image: "assets/Fruits/grape.png"),
    Fruit(name: "JACK FRUIT", image: "assets/Fruits/jackfruit.png"),
    Fruit(name: "KIWI", image: "assets/Fruits/kiwi.png"),
    Fruit(name: "LEMON", image: "assets/Fruits/lemon.png"),
    Fruit(name: "MANGO", image: "assets/Fruits/mango.png"),
    Fruit(name: "ORANGE", image: "assets/Fruits/orange.png"),
    Fruit(name: "PAPAYA", image: "assets/Fruits/papaya.png"),
    Fruit(name: "PASSION FRUIT", image: "assets/Fruits/passionfruit.png"),
    Fruit(name: "POMEGRANATE", image: "assets/Fruits/pomegranate.png"),
    Fruit(name: "STRAWBERRY", image: "assets/Fruits/strawberry.png"),
    Fruit(name: "WATERMELON", image: "assets/Fruits/watermelon.png"),
    // Add more fruits as needed
  ];

  double speechRate = 0.2; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakFruitName(fruitList[currentFruitIndex].name);
    }
  }

  void speakFruitName(String animalName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(animalName);
  }

  void nextFruit() {
    setState(() {
      currentFruitIndex = (currentFruitIndex + 1) % fruitList.length;
      if (autoPlayEnabled){
        speakFruitName(fruitList[currentFruitIndex].name);
      }
    });
  }

  void previousFruit() {
    setState(() {
      currentFruitIndex =
          (currentFruitIndex - 1 + fruitList.length) % fruitList.length;
      if (autoPlayEnabled){
        speakFruitName(fruitList[currentFruitIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Fruit currentFruit = fruitList[currentFruitIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align items with space between
              children: [
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text('Auto Play'),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: autoPlayEnabled,
                        onChanged: (value) {
                          setState(() {
                            autoPlayEnabled = value;
                          });
                          // Speak the colour name if auto play enabled
                          if (autoPlayEnabled) {
                            speakFruitName(currentFruit.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakFruitName(currentFruit.name);
                      },
                      icon: Icon(
                        Icons.volume_up_sharp,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30,),
            Image.asset(currentFruit.image, height: 280, width: 280),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentFruit.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
                // SizedBox(width: 20,),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousFruit,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextFruit,
                  icon: Icon(Icons.arrow_circle_right_outlined, size: 60,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Fruit {
  final String name;
  final String image;

  Fruit({required this.name, required this.image});
}
