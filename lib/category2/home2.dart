import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/agepage.dart';
import 'package:game/auth/save1.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category2/game2/game2.dart';
import 'package:game/category2/learn2/learn2.dart';
import 'package:game/category3/learn3/Story/Story1.dart';
import 'package:game/category3/learn3/Story/Story2.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn//flowers.dart';
import 'dart:io';

import 'package:game/learn/Stories/storysection.dart';

class Home2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Home2({super.key, required this.username, required this.email, required this.age, required this.subscribedCategory});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int currentindex = 0;
  List myPages = [Flowers(), Numbers()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"), backgroundColor: Colors.blue.shade100,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(accountName: Text(widget.username), accountEmail: Text(widget.email),
                decoration: BoxDecoration(color: Colors.lightBlue),),
              ListTile(
                  title: Text("Home"),leading: Icon(Icons.home),
                  onTap: (){
                    Navigator.of(context).pop();
                  }
              ),
              ListTile(
                title: Text("Age"), leading: Icon(Icons.change_circle),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AgePage(
                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                  )));
                },
              ),
              ListTile(
                  title: Text("Subscription"),leading: Icon(Icons.subscriptions),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                      username: widget.username, email: widget.email,
                      age: widget.age, subscribedCategory: widget.subscribedCategory,)));
                  }
                ),

              ListTile(
                title: Text("Logout"), leading: Icon(Icons.logout),
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Save1(
                      username: widget.username, useremail: widget.email,
                    userage: widget.age, subscribedCategory: widget.subscribedCategory,)));
                }
              ),
            ],
          ),
        ),

        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Hello, " + widget.username,
                          style: TextStyle(
                            fontFamily: 'Balsamiq Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30,),
                CarouselSlider(
                  items: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Learn2(
                          username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                        )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/home/learn2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Game2(
                          username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                        )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/home/games2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1, // Adjust this value to fit your layout
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text("Hear the stories...",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30,),
                        Card(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstStory()));
                            },
                            child: Column(
                              children: [
                                Image.asset("assets/story/foxstory.png", height: 200, width: 300,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Card(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondStory()));
                            },
                            child: Column(
                              children: [
                                Image.asset("assets/story/proudrose.png", height: 200, width: 300,),

                              ],
                            ),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StorySection()));
                        }, child: Text("Go to stories"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}
