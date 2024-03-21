import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/logout.dart';
import 'package:game/auth/save1.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/learn1/learn1.dart';
import 'package:game/category2/game2/game2.dart';
import 'package:game/category2/learn2/learn2.dart';
import 'package:game/category3/learn3/Story/Story1.dart';
import 'package:game/category3/learn3/Story/Story2.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn//flowers.dart';
import 'dart:io';

class Home2 extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const Home2({super.key, required this.username, required this.email, required this.age});

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(accountName: Text(widget.username), accountEmail: Text(widget.email),
                decoration: BoxDecoration(color: Colors.lightBlue),),
              ListTile(
                  title: Text("Home"),leading: Icon(Icons.home),
                  onTap: (){
                    //        Navigator.of(context).pop();
                  }
              ),
              ListTile(
                title: Text("Games"), leading: Icon(Icons.games),
              ),
              ListTile(
                title: Text("Logout"), leading: Icon(Icons.logout),
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage1(
                      username: widget.username, useremail: widget.email, userage: widget.age)));
                }
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              currentindex = index;
            });
          },
          currentIndex: currentindex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "pp"),
            BottomNavigationBarItem(icon: Icon(Icons.access_alarm_outlined),label: "new" )],
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
                      Text("Hello, " + widget.username,
                        style: TextStyle(
                          fontFamily: 'Balsamiq Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      // Text(
                      //   "Let's Learn And Play ENGLISH",
                      //   style: TextStyle(
                      //     fontFamily: 'Balsamiq Sans',
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 30,
                      //   ),
                      // ),
                      // SizedBox(height: 10,),
                    ],
                  ),
                ),

                // card
                // CarouselSlider(items: [
                //   Card(
                //     child: GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>CapitalLetter()));
                //       },
                //       child: Column(
                //         children: [
                //           Image.asset("assets/home/capital.png",height: 212.90, width: 300,),
                //         ],
                //       ),
                //     ),
                //   ),
                //
                //   Card(
                //     child: GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>SmallLetter()));
                //       },
                //       child: Column(
                //         children: [
                //           Image.asset("assets/home/small.png", height: 212.90, width: 300,),
                //         ],
                //       ),
                //     ),
                //     //child: Image.asset("assets/images/img1.png", ),
                //   ),
                // ], options: CarouselOptions(autoPlay: true, viewportFraction: 16/9)
                // ),


                // CarouselSlider(
                //   items: [
                //     GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>CapitalLetter()));
                //       },
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Image.asset(
                //           "assets/home/capital.png",
                //           // height: 212.90,
                //           // width: 300,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>SmallLetter()));
                //       },
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Image.asset(
                //           "assets/home/small.png",
                //           // height: 212.90,
                //           // width: 300,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //   ],
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 1, // Adjust this value to fit your layout
                //   ),
                // ),
                //

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Learn2()));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/home/learn2.png", fit: BoxFit.contain, height: 150, width: 150,),
                          Text("Learn", style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(width: 40,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Game2()));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/home/games2.png", fit: BoxFit.contain, height: 150, width: 150,),
                          Text("Games", style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ],
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
                                Image.asset("assets/home/foxstory.png", height: 200, width: 300,),
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
                                Image.asset("assets/home/proudrose.png", height: 200, width: 300,),

                              ],
                            ),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstStory()));
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
