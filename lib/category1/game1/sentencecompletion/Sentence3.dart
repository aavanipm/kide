import 'package:flutter/material.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence2.dart';
import 'package:game/category1/game1/sentencecompletion/Sentencelevels.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category3/home3.dart';

class Sentence3 extends StatelessWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const Sentence3({Key? key, required this.username, required this.email, required this.age, required this.subscribedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Completion'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
              SentenceCompletionItem(
                sentence: '* My dog __________ to play.',
                options: ['loves', 'love', 'like'],
                correctAnswer: 'loves',
                username: username,
                email: email,
                age: age,
                subscribedCategory: subscribedCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SentenceCompletionItem extends StatefulWidget {
  final String sentence;
  final List<String> options;
  final String correctAnswer;
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const SentenceCompletionItem({
    required this.sentence,
    required this.options,
    required this.correctAnswer,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  });

  @override
  _SentenceCompletionItemState createState() => _SentenceCompletionItemState();
}


class _SentenceCompletionItemState extends State<SentenceCompletionItem> {
  String? selectedOption;
  bool answerChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: [
                TextSpan(text: 'My dog '),
                TextSpan(
                  text: selectedOption != null ? selectedOption! : '______',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' to play.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Wrap(
            spacing: 10,
            children: widget.options.map((option) {
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
                final String message = selectedOption == widget.correctAnswer
                    ? 'Correct!'
                    : 'Incorrect!';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  duration: const Duration(seconds: 1),
                ));
                setState(() {
                  answerChecked = selectedOption == widget.correctAnswer;
                });
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Sentence3(
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
    );
  }
}