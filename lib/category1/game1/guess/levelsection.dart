import 'package:flutter/material.dart';
import 'package:game/category1/game1/guess/GuessingGame1.dart';
import 'package:game/category1/game1/guess/GuessingGame2.dart';
import 'package:game/category1/game1/guess/GuessingGame3.dart';
import 'package:game/category1/game1/guess/GuessingGame4.dart';
import 'package:game/category1/game1/guess/GuessingGame5.dart';
import 'package:game/category1/game1/guess/GuessingGame6.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guessing Game'),
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
                crossAxisCount: 3, // Adjust the number of columns as needed
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: List.generate(
                  10, // Number of levels
                      (index) {
                    int levelNumber = index + 1;
                    bool isLocked = levelNumber > 5; // Lock levels 6-10

                    return GestureDetector(
                      onTap: () {
                        if (isLocked) {
                          // Handle locked level selection (optional)
                        } else {
                          if (levelNumber == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuessingGame1(),
                              ),
                            );
                          } else if (levelNumber == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuessingGame2(),
                              ),
                            );
                          } else if (levelNumber == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuessingGame3(),
                              ),
                            );
                          } else if(levelNumber == 4){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=> GuessingGame4()
                              ),
                            );
                          } else if(levelNumber == 4){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=> GuessingGame5()
                              ),
                            );
                          } else if(levelNumber == 6) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GuessingGame6()
                              )
                            );
                          }
                          // Add navigation for other levels as needed
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLocked ? Colors.grey : Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Level $levelNumber',
                            style:  TextStyle(
                              color: isLocked ? Colors.white : Colors.white,
                              fontSize: 18,
                            ),
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
}
