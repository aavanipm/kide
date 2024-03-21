import 'package:flutter/material.dart';

class SentenceCompletionScreen extends StatelessWidget {
  const SentenceCompletionScreen({super.key});

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
                'Complete the sentences below:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* The sky is __________.',
                options: ['blue', 'green', 'red'],
                correctAnswer: 'blue',
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* I like to eat __________.',
                options: ['pizza', 'ice cream', 'juice'],
                correctAnswer: 'pizza',
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* My dog __________ to play.',
                options: ['loves', 'love', 'like'],
                correctAnswer: 'loves',
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* How __________ does this cost?.',
                options: ['many', 'much', 'more'],
                correctAnswer: 'much',
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* I __________ to the park yesterday..',
                options: ['go', 'wanted', 'went'],
                correctAnswer: 'went',
              ),
              SizedBox(height: 20),
              SentenceCompletionItem(
                sentence: '* She __________ computer games last night..',
                options: ['play', 'plays', 'played'],
                correctAnswer: 'played',
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.sentence,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: widget.options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedOption == option,
              onSelected: (isSelected) {
                setState(() {
                  selectedOption = isSelected ? option : null;
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final String message = selectedOption == widget.correctAnswer
                ? 'Correct!'
                : 'Incorrect!';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 1),
            ));
          },
          child: const Text('Check Answer'),
        ),
      ],
    );
  }
}
