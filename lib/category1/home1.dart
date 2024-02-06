import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/game1.dart';
import 'package:game/category1/learn1/learn1.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn//flowers.dart';
import 'package:game/Home/logout.dart';

class Home1 extends StatefulWidget {
  final String username;
  final String email;
  const Home1({super.key, required this.username, required this.email});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
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
                    //        Navigator.of(context).pop();
                  }
              ),
              ListTile(
                title: Text("Games"), leading: Icon(Icons.games),
              ),
              ListTile(
                title: Text("Logout"), leading: Icon(Icons.logout),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
                },
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

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text("Categories", style: TextStyle(fontSize: 25),),
              ),
              SizedBox(height: 10,),


              CarouselSlider(items: [
                Card(
                  child: Image.asset("assets/images/img1.png", ),
                ),
                Card(
                  child: Image.asset("assets/images/img2.png",),
                )
              ], options: CarouselOptions(autoPlay: true, viewportFraction: 16/9)
              ),

              SizedBox(height: 30,),

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Game1()));
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/home/games1.png", fit: BoxFit.contain, height: 150, width: 150,),
                        Text("Games", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
