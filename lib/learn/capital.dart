import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CapitalLetter extends StatefulWidget {
  @override
  _CapitalLetterState createState() => _CapitalLetterState();
}

class _CapitalLetterState extends State<CapitalLetter> {
  FlutterTts flutterTts = FlutterTts();
  int currentAlphabetIndex = 0;
  bool autoPlayEnabled = false;
  List<Capital> alphabetList = [
    Capital(name: "A", image: "assets/Alphabets/capital/A.png"),
    Capital(name: "B", image: "assets/Alphabets/capital/B.png"),
    Capital(name: "C", image: "assets/Alphabets/capital/C.png"),
    Capital(name: "D", image: "assets/Alphabets/capital/D.png"),
    Capital(name: "E", image: "assets/Alphabets/capital/E.png"),
    Capital(name: "F", image: "assets/Alphabets/capital/F.png"),
    Capital(name: "G", image: "assets/Alphabets/capital/G.png"),
    Capital(name: "H", image: "assets/Alphabets/capital/H.png"),
    Capital(name: "I", image: "assets/Alphabets/capital/I.png"),
    Capital(name: "J", image: "assets/Alphabets/capital/J.png"),
    Capital(name: "K", image: "assets/Alphabets/capital/K.png"),
    Capital(name: "L", image: "assets/Alphabets/capital/L.png"),
    Capital(name: "M", image: "assets/Alphabets/capital/M.png"),
    Capital(name: "N", image: "assets/Alphabets/capital/N.png"),
    Capital(name: "O", image: "assets/Alphabets/capital/O.png"),
    Capital(name: "P", image: "assets/Alphabets/capital/P.png"),
    Capital(name: "Q", image: "assets/Alphabets/capital/Q.png"),
    Capital(name: "R", image: "assets/Alphabets/capital/R.png"),
    Capital(name: "S", image: "assets/Alphabets/capital/S.png"),
    Capital(name: "T", image: "assets/Alphabets/capital/T.png"),
    Capital(name: "U", image: "assets/Alphabets/capital/U.png"),
    Capital(name: "V", image: "assets/Alphabets/capital/V.png"),
    Capital(name: "W", image: "assets/Alphabets/capital/W.png"),
    Capital(name: "X", image: "assets/Alphabets/capital/X.png"),
    Capital(name: "Y", image: "assets/Alphabets/capital/Y.png"),
    Capital(name: "Z", image: "assets/Alphabets/capital/Z.png"),
  ];

  double speechRate = 0.2;

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakAlphabetName(alphabetList[currentAlphabetIndex].name);
    }
  }

  void speakAlphabetName(String alphabetName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(alphabetName);
  }

  void nextAlphabet() {
    setState(() {
      currentAlphabetIndex = (currentAlphabetIndex + 1) % alphabetList.length;
      if (autoPlayEnabled){
        speakAlphabetName(alphabetList[currentAlphabetIndex].name);
      }
    });
  }

  void previousAlphabet() {
    setState(() {
      currentAlphabetIndex =
          (currentAlphabetIndex - 1 + alphabetList.length) % alphabetList.length;
      if (autoPlayEnabled){
        speakAlphabetName(alphabetList[currentAlphabetIndex].name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Capital currentAlphabet = alphabetList[currentAlphabetIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Capital Letters'),
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
                          if (autoPlayEnabled) {
                            speakAlphabetName(currentAlphabet.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakAlphabetName(currentAlphabet.name);
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
            Image.asset(currentAlphabet.image, height: 150, width: 150),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousAlphabet,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextAlphabet,
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

class Capital {
  final String name;
  final String image;

  Capital({required this.name, required this.image});
}
