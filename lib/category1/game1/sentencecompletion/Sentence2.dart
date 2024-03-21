import 'package:flutter/material.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence2.dart';
import 'package:game/category1/game1/sentencecompletion/Sentence3.dart';
import 'package:game/category1/game1/sentencecompletion/Sentencelevels.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category3/home3.dart';

class Sentence2 extends StatelessWidget {
  const Sentence2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Completion'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
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
                sentence: '* I like to eat __________.',
                options: ['pizza', 'ice cream', 'juice'],
                correctAnswer: 'pizza',
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

  const SentenceCompletionItem({
    required this.sentence,
    required this.options,
    required this.correctAnswer,
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
                TextSpan(text: 'I like to eat '),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home3(
                            username: '', email: '', age: '',)));
                      },
                      child: Text('Go to Home'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Sentence3()));
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