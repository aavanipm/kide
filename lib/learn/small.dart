import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:game/learn/small.dart';

class SmallLetter extends StatefulWidget {
  @override
  _SmallLetterState createState() => _SmallLetterState();
}

class _SmallLetterState extends State<SmallLetter> {
  FlutterTts flutterTts = FlutterTts();
  int currentAlphabetIndex = 0;

  List<Small> alphabetList = [
    Small(name: "a", image: "assets/Alphabets/small/a.png"),
    Small(name: "b", image: "assets/Alphabets/small/b.png",),
    Small(name: "c", image: "assets/Alphabets/small/c.png",),
    Small(name: "d", image: "assets/Alphabets/small/d.png"),
    Small(name: "e", image: "assets/Alphabets/small/e.png"),
    Small(name: "f", image: "assets/Alphabets/small/f.png"),
    Small(name: "g", image: "assets/Alphabets/small/g.png"),
    Small(name: "h", image: "assets/Alphabets/small/h.png"),
    Small(name: "i", image: "assets/Alphabets/small/i.png"),
    Small(name: "j", image: "assets/Alphabets/small/j.png"),
    Small(name: "k", image: "assets/Alphabets/small/k.png"),
    Small(name: "l", image: "assets/Alphabets/small/l.png"),
    Small(name: "m", image: "assets/Alphabets/small/m.png"),
    Small(name: "n", image: "assets/Alphabets/small/n.png"),
    Small(name: "o", image: "assets/Alphabets/small/o.png"),
    Small(name: "p", image: "assets/Alphabets/small/p.png"),
    Small(name: "q", image: "assets/Alphabets/small/q.png"),
    Small(name: "r", image: "assets/Alphabets/small/r.png"),
    Small(name: "s", image: "assets/Alphabets/small/s.png"),
    Small(name: "t", image: "assets/Alphabets/small/t.png"),
    Small(name: "u", image: "assets/Alphabets/small/u.png"),
    Small(name: "v", image: "assets/Alphabets/small/v.png"),
    Small(name: "w", image: "assets/Alphabets/small/w.png"),
    Small(name: "x", image: "assets/Alphabets/small/x.png"),
    Small(name: "y", image: "assets/Alphabets/small/y.png"),
    Small(name: "z", image: "assets/Alphabets/small/z.png"),

    // Add more alphabets as needed
  ];

  double speechRate = 0.2; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  void speakAlphabetName(String alphabetName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(alphabetName);
  }

  void nextAlphabet() {
    setState(() {
      currentAlphabetIndex = (currentAlphabetIndex + 1) % alphabetList.length;
    });
  }

  void previousAlphabet() {
    setState(() {
      currentAlphabetIndex =
          (currentAlphabetIndex - 1 + alphabetList.length) % alphabetList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Small currentAlphabet = alphabetList[currentAlphabetIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 300,),
                IconButton(onPressed: (){
                  speakAlphabetName(currentAlphabet.name);
                }, icon: Icon(Icons.volume_up_sharp, size: 35,)
                ),
              ],
            ),

            SizedBox(height: 30,),
            Image.asset(currentAlphabet.image, height: 150, width: 150),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   currentAlphabet.name,
                //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                // ),
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

class Small {
  final String name;
  final String image;

  Small({required this.name, required this.image});
}
