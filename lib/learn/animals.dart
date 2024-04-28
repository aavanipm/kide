import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Animals extends StatefulWidget {
  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  FlutterTts flutterTts = FlutterTts();
  int currentAnimalIndex = 0;
  bool autoPlayEnabled = false;

  List<Animal> animalList = [
    Animal(name: "BEAR", image: "assets/animals/bear.png"),
    Animal(name: "CAMEL", image: "assets/animals/camel.png"),
    Animal(name: "CAT", image: "assets/animals/cat.png"),
    Animal(name: "CHEETAH", image: "assets/animals/cheetah.png"),
    Animal(name: "DEER", image: "assets/animals/deer.png"),
    Animal(name: "DOG", image: "assets/animals/dog.png"),
    Animal(name: "DONKEY", image: "assets/animals/donkey.png"),
    Animal(name: "ELEPHANT", image: "assets/animals/elephant.png"),
    Animal(name: "FOX", image: "assets/animals/fox.png"),
    Animal(name: "GIRAFFE", image: "assets/animals/giraffe.png"),
    Animal(name: "GOAT", image: "assets/animals/goat.png"),
    Animal(name: "HORSE", image: "assets/animals/horse.png"),
    Animal(name: "KANGAROO", image: "assets/animals/kangaroo.png"),
    Animal(name: "LION", image: "assets/animals/lion.png"),
    Animal(name: "MONKEY", image: "assets/animals/monkey.png"),
    Animal(name: "PIG", image: "assets/animals/pig.png"),
    Animal(name: "SHEEP", image: "assets/animals/sheep.png"),
    Animal(name: "SQUIRREL", image: "assets/animals/squirrel.png"),
    Animal(name: "TIGER", image: "assets/animals/tiger.png"),
    Animal(name: "YAK", image: "assets/animals/yak.png"),
  ];

  double speechRate = 0.2;

  @override
  void initState (){
    super.initState();
    if (autoPlayEnabled){
      speakAnimalName(animalList[currentAnimalIndex].name);
    }
  }

   void speakAnimalName(String animalName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    await flutterTts.speak(animalName);
  }

  void nextAnimal() {
    setState(() {
      currentAnimalIndex = (currentAnimalIndex + 1) % animalList.length;
      if (autoPlayEnabled){
        speakAnimalName(animalList[currentAnimalIndex].name);
      }
    });
  }

  void previousAnimal() {
    setState(() {
      currentAnimalIndex =
          (currentAnimalIndex - 1 + animalList.length) % animalList.length;
      if (autoPlayEnabled){
        speakAnimalName(animalList[currentAnimalIndex].name);
      }
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
                            speakAnimalName(currentAnimal.name);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 200,),
                    IconButton(
                      onPressed: () {
                        speakAnimalName(currentAnimal.name);
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
            Image.asset(currentAnimal.image, height: 280, width: 280),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentAnimal.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousAnimal,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                SizedBox(width: 20,),
                IconButton(
                  onPressed: nextAnimal,
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

class Animal {
  final String name;
  final String image;

  Animal({required this.name, required this.image});
}
