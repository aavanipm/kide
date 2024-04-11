import 'package:flutter/material.dart';
import 'package:game/category1/game1/search/Search1.dart';
import 'package:game/category1/game1/search/Search2.dart';
import 'package:game/category1/game1/search/Search3.dart';
import 'package:game/category1/game1/search/Search4.dart';
import 'package:game/category1/game1/search/Search5.dart';
import 'package:game/category1/game1/search/Search6.dart';
import 'package:game/category1/game1/search/Search7.dart';
import 'package:game/category1/game1/search/search10.dart';
import 'package:game/category1/game1/search/search8.dart';
import 'package:game/category1/game1/search/search9.dart';
import 'package:game/category1/home1.dart';

class SearchLevel extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SearchLevel({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);
  @override
  State<SearchLevel> createState() => _SearchLevelState();
}

class _SearchLevelState extends State<SearchLevel> {
  List<Search> values = [
    Search(name: "1"),
    Search(name: "2"),
    Search(name: "3"),
    Search(name: "4"),
    Search(name: "5"),
    Search(name: "6"),
    Search(name: "7"),
    Search(name: "8"),
    Search(name: "9"),
    Search(name: "10"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Levels"), backgroundColor: Colors.blue.shade100,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context)=>Home1(
              username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
            ))
            );
          }, icon: Icon(Icons.home)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemCount: values.length,
          itemBuilder: (context, index) {
            return fillCard(context, values[index]);
          },
        ),
      ),
    );
  }

  Widget fillCard(BuildContext context, Search val) {
    return GestureDetector(
      onTap: () {
        // If the level is unlocked, navigate to it
        switch (val.name) {
          case '1':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search1()));
            break;
          case '2':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search2()));
            break;
          case '3':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search3()));
            break;
          case '4':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search4()));
            break;
          case '5':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search5()));
            break;
          case '6':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search6()));
            break;
          case '7':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search7()));
            break;
          case '8':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search8()));
            break;
          case '9':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search9()));
            break;
          case '10':
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search10()));
            break;          default:
            break;
        }
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                val.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Search {
  final String name;

  Search({required this.name});
}
