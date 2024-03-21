import 'package:flutter/material.dart';

import 'package:game/category1/game1/search/Search1.dart';
import 'package:game/category1/game1/search/search2.dart';

class SearchLevel extends StatefulWidget {
  const SearchLevel({super.key});

  @override
  State<SearchLevel> createState() => _SearchLevelState();
}

class _SearchLevelState extends State<SearchLevel> {
  List<Search> values = [
    Search(name: "1"),
    Search(name: "2"),
    // Search(name: "3"),
    // Search(name: "4"),
    // Search(name: "5"),
    // Search(name: "6"),
    // Search(name: "7"),
    // Search(name: "8"),
    // Search(name: "9"),
    // Search(name: "10"),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: values.length,
            itemBuilder: (context, index){
              return fillcard(context, values[index]);
            }
        ),
      ),
    );
  }
  Widget fillcard(BuildContext context, Search val) {
    bool isUnlocked = int.parse(val.name) <= 5; // Check if the level is unlocked
    Color? cardColor = isUnlocked ? Colors.blue.shade100 : Colors.grey.shade100; // Color based on unlocked status

    return GestureDetector(
      onTap: () {
        if (isUnlocked) {
          switch (val.name) {
            case '1':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search1()));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search2()));
              break;
            // case '3':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill3()));
            //   break;
            // case '4':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill4()));
            //   break;
            // case '5':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill5()));
            //   break;
            // case '6':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill6()));
            //   break;
            // case '7':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill7()));
            //   break;
            // case '8':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill8()));
            //   break;
            // case '9':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill9()));
            //   break;
            // case '10':
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Fill10()));
            //   break;
            default:
              break;
          }
        } else {
          // Handle locked level
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Level Locked'),
                content: Text('This level is locked. You need to complete previous levels to unlock it.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Card(
        elevation: 3,
        color: cardColor, // Assigning the card color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                val.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: isUnlocked ? Colors.black : Colors.grey, // Text color based on unlocked status
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Search{
  final String name;

  Search({required this.name});
}

