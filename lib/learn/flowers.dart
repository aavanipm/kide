import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Flowers extends StatefulWidget {
  @override
  _FlowersState createState() => _FlowersState();
}

class _FlowersState extends State<Flowers> {
  FlutterTts flutterTts = FlutterTts();
  int currentFlowerIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback
  List<Flower> flowerList = [
    Flower(name: "ROSE", image: "assets/Flowers/rose.png"),
    Flower(name: "LOTUS", image: "assets/Flowers/lotus.png"),
    Flower(name: "JASMINE", image: "assets/Flowers/jasmine.png"),
    Flower(name: "MARIGOLD", image: "assets/Flowers/marigold.png"),
    Flower(name: "COSMOS", image: 'assets/Flowers/cosmos.png'),
    Flower(name: "ALLAMANDA", image: "assets/Flowers/allamanda.png"),
    Flower(name: "BOUGAINVILLEA", image: "assets/Flowers/bougainvillea.png"),
    Flower(name: "SUNFLOWER", image: "assets/Flowers/sunflower.png"),
    Flower(name: "HIBISCUS", image: "assets/Flowers/hibiscus.png"),
    Flower(name: "LAVENDER", image: "assets/Flowers/lavender.png"),
    Flower(name: "DAHLIA", image: "assets/Flowers/dahlia.png"),
    Flower(name: "DAISY", image: "assets/Flowers/daisy.png"),
    Flower(name: "LILY", image: "assets/Flowers/lily.png"),
    Flower(name: "TULIP", image: "assets/Flowers/tulip.png"),
    Flower(name: "OLEANDER", image: "assets/Flowers/oleander.png"),
    // Add more flowers as needed
  ];

  double speechRate = 0.2; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakFlowerName(flowerList[currentFlowerIndex].name);
    }
  }

  void speakFlowerName(String flowerName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(flowerName);
  }

  void nextFlower() {
    setState(() {
      currentFlowerIndex = (currentFlowerIndex + 1) % flowerList.length;
      if (autoPlayEnabled){
        speakFlowerName(flowerList[currentFlowerIndex].name);
      }
    });
  }

  void previousFlower() {
    setState(() {
      currentFlowerIndex =
          (currentFlowerIndex - 1 + flowerList.length) % flowerList.length;
      if (autoPlayEnabled){
        speakFlowerName(flowerList[currentFlowerIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Flower currentFlower = flowerList[currentFlowerIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flower Page'),
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
                            speakFlowerName(currentFlower.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakFlowerName(currentFlower.name);
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
            Image.asset(currentFlower.image, height: 280, width: 280),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentFlower.name,
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
                  onPressed: previousFlower,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextFlower,
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

class Flower {
  final String name;
  final String image;

  Flower({required this.name, required this.image});
}
