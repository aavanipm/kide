import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Colours extends StatefulWidget {
  const Colours({Key? key}) : super(key: key);

  @override
  _ColoursState createState() => _ColoursState();
}

class _ColoursState extends State<Colours> {
  FlutterTts flutterTts = FlutterTts();
  int currentColourIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback
  List<Colour> colourList = [
    Colour(name: "BLACK", backgroundColor: Colors.black),
    Colour(name: "BLUE", backgroundColor: Colors.blue),
    Colour(name: "GREEN", backgroundColor: Colors.green),
    Colour(name: "PINK", backgroundColor: Colors.pink),
    Colour(name: "WHITE", backgroundColor: Colors.white),
    Colour(name: "BROWN", backgroundColor: Colors.brown),
    Colour(name: "RED", backgroundColor: Colors.red),
    Colour(name: "YELLOW", backgroundColor: Colors.yellow),
    Colour(name: "ORANGE", backgroundColor: Colors.orange),
    Colour(name: "GREY", backgroundColor: Colors.grey),
    Colour(name: "INDIGO", backgroundColor: Colors.indigo),
    Colour(name: "PURPLE", backgroundColor: Colors.purple),
    // Add more colours as needed
  ];

  double speechRate = 0.2;

  @override
  void initState() {
    super.initState();
    if (autoPlayEnabled) {
      speakColourName(colourList[currentColourIndex].name);
    }
  }

  void speakColourName(String colourName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(colourName);
  }

  void nextColour() {
    setState(() {
      currentColourIndex = (currentColourIndex + 1) % colourList.length;
      if (autoPlayEnabled) {
        speakColourName(colourList[currentColourIndex].name);
      }
    });
  }

  void previousColour() {
    setState(() {
      currentColourIndex =
          (currentColourIndex - 1 + colourList.length) % colourList.length;
      if (autoPlayEnabled) {
        speakColourName(colourList[currentColourIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Colour currentColour = colourList[currentColourIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Colours Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
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
                            speakColourName(currentColour.name);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    speakColourName(currentColour.name);
                  },
                  icon: Icon(
                    Icons.volume_up_sharp,
                    size: 35,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 200,
              width: 200,
              color: currentColour.backgroundColor,
            ),
            SizedBox(height: 30),
            Text(
              currentColour.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousColour,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: nextColour,
                  icon: Icon(Icons.arrow_circle_right_outlined, size: 60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Colour {
  final String name;
  final Color? backgroundColor; // Option for background color

  Colour({required this.name, required this.backgroundColor});
}
