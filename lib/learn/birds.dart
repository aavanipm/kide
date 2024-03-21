import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Birds extends StatefulWidget {
  @override
  _BirdsState createState() => _BirdsState();
}

class _BirdsState extends State<Birds> {
  FlutterTts flutterTts = FlutterTts();
  int currentBirdIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback

  List<Bird> birdList = [
    Bird(name: "DUCK", image: "assets/Birds/duck.png"),
    Bird(name: "EAGLE", image: "assets/Birds/eagle.png"),
    Bird(name: "CROW", image: "assets/Birds/crow.png"),
    Bird(name: "HEN", image: "assets/Birds/hen.png"),
    Bird(name: "KINGFISHER", image: "assets/Birds/kingfisher.png"),
    Bird(name: "OSTRICH", image: "assets/Birds/ostrich.png"),
    Bird(name: "PARROT", image: "assets/Birds/parrot.png"),
    Bird(name: "ROOSTER", image: "assets/Birds/rooster.png"),
    Bird(name: "PENGUIN", image: "assets/Birds/penguin.png"),
    Bird(name: "EMU", image: "assets/Birds/emu.png"),
    Bird(name: "PIGEON", image: "assets/Birds/pigeon.png"),
    Bird(name: "MYNA", image: "assets/Birds/myna.png"),
    Bird(name: "ROBIN", image: "assets/Birds/robin.png"),
    Bird(name: "SWAN", image: "assets/Birds/swan.png"),
    Bird(name: "PEACOCK", image: "assets/Birds/peacock.png"),
    Bird(name: "FLAMINGO", image: "assets/Birds/flamingo.png"),
    Bird(name: "TURKEY", image: "assets/Birds/turkey.png"),
    Bird(name: "WREN", image: "assets/Birds/wren.png"),

    // Add more birds as needed
  ];

  double speechRate = 0.2; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakBirdName(birdList[currentBirdIndex].name);
    }
  }

  void speakBirdName(String birdName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(birdName);
  }

  void nextBird() {
    setState(() {
      currentBirdIndex = (currentBirdIndex + 1) % birdList.length;
      if (autoPlayEnabled){
        speakBirdName(birdList[currentBirdIndex].name);
      }
    });
  }

  void previousBird() {
    setState(() {
      currentBirdIndex =
          (currentBirdIndex - 1 + birdList.length) % birdList.length;
      if (autoPlayEnabled){
        speakBirdName(birdList[currentBirdIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Bird currentBird = birdList[currentBirdIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Birds Page'),
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
                            speakBirdName(currentBird.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakBirdName(currentBird.name);
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
            Image.asset(currentBird.image, height: 280, width: 280),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentBird.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousBird,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextBird,
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

class Bird {
  final String name;
  final String image;

  Bird({required this.name, required this.image});
}
