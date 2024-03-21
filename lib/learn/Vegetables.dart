import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Vegetables extends StatefulWidget {
  @override
  _VegetablesState createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  FlutterTts flutterTts = FlutterTts();
  int currentVegetableIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback

  List<Vegetable> vegetableList = [
    Vegetable(name: "BEANS", image: "assets/Vegetables/beans.png"),
    Vegetable(name: "BROCCOLI", image: "assets/Vegetables/broccoli.png"),
    Vegetable(name: "CARROT", image: "assets/Vegetables/carrot.png"),
    Vegetable(name: "CAULIFLOWER", image: "assets/Vegetables/cauliflower.png"),
    Vegetable(name: "CUCUMBER", image: "assets/Vegetables/cucumber.png"),
    Vegetable(name: "POTATO", image: "assets/Vegetables/potato.png"),
    Vegetable(name: "PUMPKIN", image: "assets/Vegetables/pumpkin.png"),
    Vegetable(name: "TOMATO", image: "assets/Vegetables/tomato.png"),

    // Add more birds as needed
  ];

  double speechRate = 0.2;

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakVegetableName(vegetableList[currentVegetableIndex].name);
    }
  }

  void speakVegetableName(String vegetableName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(vegetableName);
  }

  void nextVegetable() {
    setState(() {
      currentVegetableIndex = (currentVegetableIndex + 1) % vegetableList.length;
      if(autoPlayEnabled){
        speakVegetableName(vegetableList[currentVegetableIndex].name);
      }
    });
  }

  void previousVegetable() {
    setState(() {
      currentVegetableIndex =
          (currentVegetableIndex - 1 + vegetableList.length) % vegetableList.length;
      if(autoPlayEnabled){
        speakVegetableName(vegetableList[currentVegetableIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Vegetable currentVegetable = vegetableList[currentVegetableIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable Page'),
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
                            speakVegetableName(currentVegetable.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakVegetableName(currentVegetable.name);
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
            Image.asset(currentVegetable.image, height: 280, width: 280),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentVegetable.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousVegetable,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextVegetable,
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

class Vegetable {
  final String name;
  final String image;

  Vegetable({required this.name, required this.image});
}
