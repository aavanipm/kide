import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Alphabets extends StatefulWidget {
  @override
  _AlphabetsState createState() => _AlphabetsState();
}

class _AlphabetsState extends State<Alphabets> {
  FlutterTts flutterTts = FlutterTts();
  int currentAlphabetIndex = 0;
  bool autoPlayEnabled = false; // Variable to track automatic playback

  List<Alphabet> alphabetList = [
    Alphabet(name: "A", capital: "assets/Alphabets/letters/capital/A.png", small: "assets/Alphabets/letters/small/a.png"),
    Alphabet(name: "B", capital: "assets/Alphabets/letters/capital/B.png", small: "assets/Alphabets/letters/small/b.png"),
    Alphabet(name: "C", capital: "assets/Alphabets/letters/capital/C.png", small: "assets/Alphabets/letters/small/c.png"),
    Alphabet(name: "D", capital: "assets/Alphabets/letters/capital/D.png", small: "assets/Alphabets/letters/small/d.png"),
    Alphabet(name: "E", capital: "assets/Alphabets/letters/capital/E.png", small: "assets/Alphabets/letters/small/e.png"),
    Alphabet(name: "F", capital: "assets/Alphabets/letters/capital/F.png", small: "assets/Alphabets/letters/small/f.png"),
    Alphabet(name: "G", capital: "assets/Alphabets/letters/capital/G.png", small: "assets/Alphabets/letters/small/g.png"),
    Alphabet(name: "H", capital: "assets/Alphabets/letters/capital/H.png", small: "assets/Alphabets/letters/small/h.png"),
    Alphabet(name: "I", capital: "assets/Alphabets/letters/capital/I.png", small: "assets/Alphabets/letters/small/i.png"),
    Alphabet(name: "J", capital: "assets/Alphabets/letters/capital/J.png", small: "assets/Alphabets/letters/small/j.png"),
    Alphabet(name: "K", capital: "assets/Alphabets/letters/capital/K.png", small: "assets/Alphabets/letters/small/k.png"),
    Alphabet(name: "L", capital: "assets/Alphabets/letters/capital/L.png", small: "assets/Alphabets/letters/small/l.png"),
    Alphabet(name: "M", capital: "assets/Alphabets/letters/capital/M.png", small: "assets/Alphabets/letters/small/m.png"),
    Alphabet(name: "N", capital: "assets/Alphabets/letters/capital/N.png", small: "assets/Alphabets/letters/small/n.png"),
    Alphabet(name: "O", capital: "assets/Alphabets/letters/capital/O.png", small: "assets/Alphabets/letters/small/o.png"),
    Alphabet(name: "P", capital: "assets/Alphabets/letters/capital/P.png", small: "assets/Alphabets/letters/small/p.png"),
    Alphabet(name: "Q", capital: "assets/Alphabets/letters/capital/Q.png", small: "assets/Alphabets/letters/small/q.png"),
    Alphabet(name: "R", capital: "assets/Alphabets/letters/capital/R.png", small: "assets/Alphabets/letters/small/r.png"),
    Alphabet(name: "S", capital: "assets/Alphabets/letters/capital/S.png", small: "assets/Alphabets/letters/small/s.png"),
    Alphabet(name: "T", capital: "assets/Alphabets/letters/capital/T.png", small: "assets/Alphabets/letters/small/t.png"),
    Alphabet(name: "U", capital: "assets/Alphabets/letters/capital/U.png", small: "assets/Alphabets/letters/small/u.png"),
    Alphabet(name: "V", capital: "assets/Alphabets/letters/capital/V.png", small: "assets/Alphabets/letters/small/v.png"),
    Alphabet(name: "W", capital: "assets/Alphabets/letters/capital/W.png", small: "assets/Alphabets/letters/small/w.png"),
    Alphabet(name: "X", capital: "assets/Alphabets/letters/capital/X.png", small: "assets/Alphabets/letters/small/x.png"),
    Alphabet(name: "Y", capital: "assets/Alphabets/letters/capital/Y.png", small: "assets/Alphabets/letters/small/y.png"),
    Alphabet(name: "Z", capital: "assets/Alphabets/letters/capital/Z.png", small: "assets/Alphabets/letters/small/z.png"),
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
    Alphabet currentAlphabet = alphabetList[currentAlphabetIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
            Image.asset(currentAlphabet.capital, height: 140, width: 140,),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 180,),
                Image.asset(currentAlphabet.small, height: 100, width: 100),
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

class Alphabet {
  final String name;
  final String capital;
  final String small;

  Alphabet({required this.name, required this.capital, required this.small});
}
