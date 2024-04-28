import 'package:flutter/material.dart';
import 'package:game/learn/Stories/Story1.dart';
import 'package:game/learn/Stories/Story2.dart';
import 'package:game/learn/Stories/Story3.dart';

class StorySection extends StatefulWidget {
  const StorySection({super.key});

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {
  List<Story> values = [
    Story(imagepath: "assets/story/foxstory.png", name: "THE FOX AND THE GRAPES"),
    Story(imagepath: "assets/story/proudrose.png", name: "THE PROUD ROSE"),
    Story(imagepath: "assets/story/bearandtwo.png", name: "THE BEAR AND THE TWO FRIENDS"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Page"),
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
            crossAxisSpacing: 16, mainAxisSpacing: 16
        ),
            itemCount: values.length,
            itemBuilder: (context, index){
              return categorycard(context, values[index]);
            }),
      ),
    );
  }
}

Widget categorycard(BuildContext context, Story val){
  return GestureDetector(
      onTap: (){
        switch(val.name){

          case 'THE FOX AND THE GRAPES':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstStory()));
            break;

          case 'THE PROUD ROSE':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondStory()));
            break;

          case 'THE BEAR AND THE TWO FRIENDS':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdStory()));
            break;

          default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.asset(val.imagepath, height: 250, width: 300,),
            SizedBox(height: 10,),
            Text(val.name, style: TextStyle(
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),
      )
  );
}

class Story {
  final String imagepath;
  final String name;

  Story({required this.imagepath, required this.name});
}