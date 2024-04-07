import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isNewGameAdded = false;

  void handleNewGameNotification() {
    setState(() {
      isNewGameAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Easy Learn',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.blueAccent,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Implement action to navigate to new games or handle notifications
                    },
                  ),
                  if (isNewGameAdded) // Show badge if new game added
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 6,
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'profile') {
                    // Handle profile action
                  } else if (value == 'score') {
                    // Handle score action
                  } else if (value == 'logout') {
                    // Handle logout action
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(value: 'profile', child: Text('Profile')),
                    const PopupMenuItem(value: 'score', child: Text('Score')),
                    const PopupMenuItem(value: 'logout', child: Text('Logout')),
                  ];
                },
              ),
            ],
            bottom: const TabBar(
              dividerColor: Colors.white,
              tabs: [
                Tab(text: 'Home',),
                Tab(text: 'Profile'),
              ],
            ),
          ),
          drawer: const Drawer(),
          body: const TabBarView(
            children: [
              // HomeTab(),
              // HomeTab(),
              // ProfileTab(),
            ],
          ),
        ),
      ),
    );
  }
}

