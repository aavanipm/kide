// LevelSelection1.dart

import 'package:flutter/material.dart';
import 'package:game/category1/game1/past%20tense/past1.dart';

class LevelSelection1 extends StatefulWidget {
  const LevelSelection1({Key? key}) : super(key: key);

  @override
  _LevelSelection1State createState() => _LevelSelection1State();
}

class _LevelSelection1State extends State<LevelSelection1> {
  List<bool> levelCompletionStatus = [false, false, false, false, false, false, false];
  List<bool> levelLockStatus = [false, false, true, true, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Level:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: List.generate(
                  7,
                      (index) {
                    int levelNumber = index + 1;
                    return GestureDetector(
                      onTap: () {
                        if (!levelLockStatus[index]) {
                          _navigateToGame(context, levelNumber);
                        } else {
                          _showSubscriptionDialog(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: levelLockStatus[index]
                              ? Colors.grey
                              : levelCompletionStatus[index]
                              ? Colors.green
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Level $levelNumber',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(BuildContext context, int levelNumber) {
    Widget gameWidget;
    switch (levelNumber) {
      case 1:
        gameWidget = PerfectTenseGame(onGameCompleted: (isCompleted) {
          setState(() {
            levelCompletionStatus[levelNumber - 1] = isCompleted;
            if (levelNumber < 7) {
              levelLockStatus[levelNumber] = false;
            }
          });
        });
        break;
      case 2:
        gameWidget = PerfectTenseGame(onGameCompleted: (isCompleted){
          setState(() {
            levelCompletionStatus[levelNumber -1] = isCompleted;
            if(levelNumber < 7)
            {
              levelLockStatus[levelNumber] =false;
            }
          });
        });
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameWidget),
    );
  }

  void _showSubscriptionDialog(BuildContext context) async {
    final bool success = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubscriptionPage()),
    );

    if (success) {
      setState(() {
        for (int i = 2; i < levelLockStatus.length; i++) {
          levelLockStatus[i] = false; // Unlock levels 4 to 7
          levelCompletionStatus[i] = false; // Reset completion status for levels 4 to 7
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subscription Successful! Levels 4 to 7 Unlocked.')),
      );
    }
  }
}
// SubscriptionPage.dart

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Unlock Premium Features',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                Navigator.pop(context, true);
              },
              child: Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}