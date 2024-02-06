import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game/learn/Colours.dart';
import 'package:game/learn/Fruits.dart';
import 'package:game/learn/Numbers.dart';
import 'package:game/learn/animals.dart';
import 'package:game/learn//flowers.dart';
import 'package:game/Home/logout.dart';

class Home extends StatefulWidget {
  final String username;
  final String email;
  const Home({super.key, required this.username, required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            BottomNavigationBarItem(icon: Icon(Icons.access_alarm_outlined),label: "new" )], ),
        
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Row(

              children: [
                Image.asset("assets/images/play.png", fit: BoxFit.contain, height: 100, width: 100,),
                Text("Learn", style: TextStyle(fontSize: 20),),
              ],
            ),


            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text("Categories", style: TextStyle(fontSize: 25),),
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Animals()));
                      },
                      child: Card(
                        child: Column(
                        children: [
                          Image.asset("assets/learning/animals.png", fit: BoxFit.contain, height: 100, width: 100,),
                          Text("Animals", style: TextStyle(fontSize: 20,))
                        ],
                      ),),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Flowers()));
                      },
                      child: Card(child: Column(
                        children: [
                          Image.asset("assets/learning/flowers.png", fit: BoxFit.contain, height: 100, width: 100,),
                          Text("Flowers", style: TextStyle(fontSize: 20),)
                        ],
                      ),),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Colours()));
                      },
                      child: Card(child: Column(
                        children: [
                          Image.asset("assets/learning/colours.png", fit: BoxFit.contain, height: 100, width: 100,),
                          Text("Colours", style: TextStyle(fontSize: 20),)
                        ],
                      ),),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Fruits()));
                      },
                      child: Card(child: Column(
                        children: [
                          Image.asset("assets/learning/fruits.png", fit: BoxFit.contain, height: 100, width: 100,),
                          Text("Fruits", style: TextStyle(fontSize: 20),)
                        ],
                      ),),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Numbers()));
                      },
                      child: Card(child: Column(
                        children: [
                          Image.asset("assets/learning/numbers.png", fit: BoxFit.contain, height: 100, width: 100,),
                          Text("Numbers", style: TextStyle(fontSize: 20),)
                        ],
                      ),),
                    ),

                  ],
                ),

              ),
            ),
            CarouselSlider(items: [
              Card(
                child: Image.asset("assets/images/img1.png", ),
              ),
              Card(
                child: Image.asset("assets/images/img2.png",),
              )
            ], options: CarouselOptions(autoPlay: true, viewportFraction: 16/9))
          ],
        ),
      )
    );
  }
}
