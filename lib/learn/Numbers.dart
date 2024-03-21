import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  FlutterTts flutterTts = FlutterTts();
  int currentNumberIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback

  List<Number> numberList = [
    Number(name: "ZERO", image: "assets/Numbers/0.png"),
    Number(name: "ONE", image: "assets/Numbers/1.png"),
    Number(name: "TWO", image: "assets/Numbers/2.png"),
    Number(name: "THREE", image: "assets/Numbers/3.png"),
    Number(name: "FOUR", image: "assets/Numbers/4.png"),
    Number(name: "FIVE", image: "assets/Numbers/5.png"),
    Number(name: "SIX", image: "assets/Numbers/6.png"),
    Number(name: "SEVEN", image: "assets/Numbers/7.png"),
    Number(name: "EIGHT", image: "assets/Numbers/8.png"),
    Number(name: "NINE", image: "assets/Numbers/9.png"),
    Number(name: "TEN", image: "assets/Numbers/10.png"),
    Number(name: "ELEVEN", image: "assets/Numbers/11.png"),
    Number(name: "TWELVE", image: "assets/Numbers/12.png"),
    Number(name: "THIRTEEN", image: "assets/Numbers/13.png"),
    Number(name: "FOURTEEN", image: "assets/Numbers/14.png"),
    Number(name: "FIFTEEN", image: "assets/Numbers/15.png"),
    Number(name: "SIXTEEN", image: "assets/Numbers/16.png"),
    Number(name: "SEVENTEEN", image: "assets/Numbers/17.png"),
    Number(name: "EIGHTEEN", image: "assets/Numbers/18.png"),
    Number(name: "NINETEEN", image: "assets/Numbers/19.png"),
    Number(name: "TWENTY", image: "assets/Numbers/20.png"),
    Number(name: "THIRTY", image: "assets/Numbers/30.png"),
    Number(name: "FORTY", image: "assets/Numbers/40.png"),
    Number(name: "FIFTY", image: "assets/Numbers/50.png"),
    Number(name: "SIXTY", image: "assets/Numbers/60.png"),
    Number(name: "SEVENTY", image: "assets/Numbers/70.png"),
    Number(name: "EIGHTY", image: "assets/Numbers/80.png"),
    Number(name: "NINETY", image: "assets/Numbers/90.png"),
    Number(name: "HUNDRED", image: "assets/Numbers/100.png"),

    // Add more numbers as needed
  ];

  double speechRate = 0.2; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakNumberName(numberList[currentNumberIndex].name);
    }
  }

  void speakNumberName(String numberName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(numberName);
  }

  void nextNumber() {
    setState(() {
      currentNumberIndex = (currentNumberIndex + 1) % numberList.length;
      if (autoPlayEnabled){
        speakNumberName(numberList[currentNumberIndex].name);
      }
    });
  }

  void previousNumber() {
    setState(() {
      currentNumberIndex =
          (currentNumberIndex - 1 + numberList.length) % numberList.length;
      if (autoPlayEnabled){
        speakNumberName(numberList[currentNumberIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Number currentNumber = numberList[currentNumberIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Number Page'),
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
                            speakNumberName(currentNumber.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakNumberName(currentNumber.name);
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
            Image.asset(currentNumber.image, height: 300, width: 300),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentNumber.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousNumber,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextNumber,
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

class Number {
  final String name;
  final String image;

  Number({required this.name, required this.image});
}
