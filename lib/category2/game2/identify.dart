import 'package:flutter/material.dart';

class Identify extends StatefulWidget {
  const Identify({super.key});

  @override
  State<Identify> createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  List<AnimalId> animals = [
    AnimalId(name: 'Zebra', image: 'assets/animals/zebra.png'),
    AnimalId(name: 'Dog', image: 'assets/animals/dog.png'),
    AnimalId(name: 'Fox', image: 'assets/animals/fox.png'),
  ];
  List<AnimalId> shuffledAnimal =[];
  int score = 0;

  @override
  void initState() {
    super.initState();
    shuffledAnimal = List.from(animals)..shuffle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identify them"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score:$score"),
          SizedBox(height: 20,),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16
            ),
            itemCount: shuffledAnimal.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AnimalCard(
                animal: shuffledAnimal[index],
                onmatched: () {
                  setState(() {
                    score += 1;
                    shuffledAnimal[index].matched = true;
                    if (shuffledAnimal.every((animal) => animal.matched)) {
                      showgame();
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
  void showgame(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("game completed"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('OK')),
        ],
      );
    });
  }
}

class AnimalId{
  final String name;
  final String image;
  bool matched;

  AnimalId({required this.name, required this.image, this.matched = false});
}

class AnimalCard extends StatefulWidget {
  final AnimalId animal;
  final Function() onmatched;
  AnimalCard({super.key, required this.animal, required this.onmatched});

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  TextEditingController textEditingController = TextEditingController();
  String typedname = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!widget.animal.matched){
          showanimalname(context);
        }

      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.animal.matched? widget.animal.image: widget.animal.image, height: 100, width: 150,),
            if(typedname.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$typedname"),
              )
          ],

        ),
      ),
    );

  }
  void showanimalname(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Guess Animal"),
        content: Column(
          children: [
            TextField(controller: TextEditingController(), onChanged: (value){
              setState(() {
                typedname=value;
              });
            },
              decoration: InputDecoration(hintText: "Type Animal"),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              String enteredname = typedname.trim();
              if(enteredname.isNotEmpty && enteredname.toLowerCase()==widget.animal.name.toLowerCase()){
                Navigator.pop(context);
                widget.onmatched();
              }
            },
                child: Text("Matched")),
          ],
        ),
      );
    },
    );
  }
}
