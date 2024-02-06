import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Animals extends StatefulWidget {
  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  FlutterTts flutterTts = FlutterTts();
  int currentAnimalIndex = 0;

  List<Animal> animalList = [
    Animal(name: "Dog", image: "assets/animals/dog.png"),
    Animal(name: "Giraffe", image: "assets/animals/zebra.png"),
    Animal(name: "Fox", image: "assets/animals/fox.png")
    // Add more animals as needed
  ];

  double speechRate = 0.5; // Adjust this value to control the speed (0.5 is slower, 1.0 is normal)

  void speakAnimalName(String animalName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(animalName);
  }

  void nextAnimal() {
    setState(() {
      currentAnimalIndex = (currentAnimalIndex + 1) % animalList.length;
    });
  }

  void previousAnimal() {
    setState(() {
      currentAnimalIndex =
          (currentAnimalIndex - 1 + animalList.length) % animalList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Animal currentAnimal = animalList[currentAnimalIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(currentAnimal.image, height: 200, width: 200),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentAnimal.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: (){
                  speakAnimalName(currentAnimal.name);
                }, icon: Icon(Icons.volume_up)),
              ],
            ),

            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     speakAnimalName(currentAnimal.name);
            //   },
            //   child: Text('Speak Animal Name'),
            // ),
            // SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousAnimal,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                IconButton(
                  onPressed: nextAnimal,
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

class Animal {
  final String name;
  final String image;

  Animal({required this.name, required this.image});
}
