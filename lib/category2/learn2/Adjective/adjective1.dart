//
// Here are some examples of adjectives:
// Shape: round, square, oval
//
// Example: The square box.
// Texture: smooth, rough, soft
//
// Example: The soft blanket.
// Age: old, young, ancient
//
// Example: The old man.
// Temperature: hot, cold, warm
//
// Example: The warm sun.
// Personality: friendly, mean, kind
//
// Example: The friendly dog.
// Origin: French, Japanese, American
//
// Example: The French cuisine.
// Material: wooden, metallic, cotton
//
// Example: The wooden table.
// Purpose: cooking, gardening, sleeping
//
// Example: The gardening tools.
// Adjectives can be used before or after the noun they describe, depending on the sentence structure. They make writing more descriptive and engaging by providing details that help readers visualize and understand the nouns better.
//

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Adjective1 extends StatelessWidget {
  const Adjective1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adjective"),
      ),
      body: Swiper(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          switch (index){
            case 0:
              return AdjectiveIntroduction();
            case 1:
              return AdjectiveDefinition();
            case 2:
              return AdjectiveExample1();
            case 3:
              return AdjectiveExample2();
            default:
              return Container();
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class AdjectiveIntroduction extends StatefulWidget {
  const AdjectiveIntroduction({super.key});

  @override
  State<AdjectiveIntroduction> createState() => _AdjectiveIntroductionState();
}

class _AdjectiveIntroductionState extends State<AdjectiveIntroduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child: Text(
            "Let's Learn Adjectives",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
  }
}

// class AdjectiveDefinition extends StatelessWidget {
//   const AdjectiveDefinition({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           "Adjectives are describing words that provide more information about nouns."
//               "They add detail and specificity to nouns by describing their qualities, characteristics, or attributes. "
//               "Adjectives can answer questions like What kind? Which one? or How many?"
//               " They help make sentences more interesting and colorful by painting a clearer picture of the noun they modify.",
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

class AdjectiveExample1 extends StatelessWidget {
  const AdjectiveExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Color: red, blue, green.",
              textAlign: TextAlign.center,
            ),
            Text(
              "The red apple.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AdjectiveExample2 extends StatelessWidget {
  const AdjectiveExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Size: big, small, tiny.",
              textAlign: TextAlign.center,
            ),
            Text(
              "The large elephant.",
              textAlign: TextAlign.center,
            ),
          ],
        ),

      ),
    );
  }
}


class AdjectiveDefinition extends StatelessWidget {
  const AdjectiveDefinition({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Adjectives are describing words that tell us more about nouns.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "They make sentences more interesting by adding details and colors.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Adjectives can answer questions like 'What kind?' 'Which one?' or 'How many?'",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bubble_chart,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "They help us create vivid pictures in our minds.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
