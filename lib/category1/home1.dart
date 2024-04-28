import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/agepage.dart';
import 'package:game/auth/save1.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/learn1/learn1.dart';
import 'package:game/learn/Stories/Story1.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn//flowers.dart';
import 'package:game/learn/Stories/Story2.dart';
import 'package:game/learn/Stories/storysection.dart';
import 'package:game/learn/capital.dart';
import 'package:game/learn/small.dart';

class Home1 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Home1({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final TextEditingController _emailController = TextEditingController();
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
                title: Text("Subscription"),leading: Icon(Icons.subscriptions),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDemoPage(
                      username: widget.username, email: widget.email,
                    age: widget.age, subscribedCategory: widget.subscribedCategory,)));
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
                title: Text("Logout"), leading: Icon(Icons.logout),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Save1(
                      username: widget.username, useremail: widget.email, userage: widget.age, subscribedCategory: widget.subscribedCategory,)
                    )
                  );
                },
              ),
            ],
          ),
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (index){
        //     setState(() {
        //       currentindex = index;
        //     });
        //   },
        //   currentIndex: currentindex,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.abc), label: "pp"),
        //     BottomNavigationBarItem(icon: Icon(Icons.access_alarm_outlined),label: "new" )],
        // ),

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
                     SizedBox(height: 20,),
                   ],
                  ),
                ),

                CarouselSlider(
                  items: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CapitalLetter()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/home/capital.png", fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SmallLetter()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/home/small.png", fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1, // Adjust this value to fit your layout
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Learn1()));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/home/learn1.png", fit: BoxFit.contain, height: 150, width: 150,),
                          Text("Learn", style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(width: 40,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Game1(
                          username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                        )));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/home/games1.png", fit: BoxFit.contain, height: 150, width: 150,),
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
