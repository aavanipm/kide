import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence2.dart';
import 'package:game/category1/home1.dart';

class Sentence1 extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Sentence1({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _Sentence1State createState() => _Sentence1State();
}

class _Sentence1State extends State<Sentence1> {
  String? selectedOption;
  bool answerChecked = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore(); // Retrieve score when widget is initialized
  }

  void _updateScoreInFirebase() async {
    if(score==0){
      await Firebase.initializeApp();
      final DocumentReference documentReference = FirebaseFirestore.instance.collection(widget.username).doc('sentence');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference = FirebaseFirestore.instance.collection(widget.username).doc('sentence');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Completion'),
        backgroundColor: Colors.blue.shade50,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber), // Icon to represent score
                SizedBox(width: 4),
                Text(score.toString()), // Display the score
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Complete the sentence below:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          TextSpan(text: 'The sky is usually '),
                          TextSpan(
                            text: selectedOption != null ? selectedOption! : '______',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Wrap(
                      spacing: 10,
                      children: ['blue', 'green', 'yellow'].map((option) {
                        return ChoiceChip(
                          label: Text(option),
                          selected: selectedOption == option,
                          onSelected: (isSelected) {
                            setState(() {
                              if (!answerChecked) {
                                selectedOption = isSelected ? option : null;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (!answerChecked)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedOption == 'blue') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Correct!'),
                              duration: const Duration(milliseconds: 600),
                            ));
                            setState(() {
                              answerChecked = true;
                              if(score==0){
                                score++; // Increment score upon correct answer
                              }
                            });
                            _updateScoreInFirebase(); // Update score in Firebase
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Incorrect!'),
                              duration: const Duration(milliseconds: 600),
                            ));
                          }
                        },
                        child: const Text('Check Answer'),
                      ),
                    ),
                  if (answerChecked)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Congratulations!',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(
                                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                                  )));
                                },
                                child: Text('Go to Home'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sentence2(
                                    username: widget.username, email: widget.email, age: widget.age, subscribedCategory: widget.subscribedCategory,
                                  )));
                                },
                                child: Text('Next Level'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
