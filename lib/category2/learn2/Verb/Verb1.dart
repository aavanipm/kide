// import 'package:flutter/material.dart';
//
// class Verb1 extends StatelessWidget {
//   const Verb1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "🌟 Let's Learn Verbs! 🌟",
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Hello!",
//               style: TextStyle(
//                 fontSize: 32.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Are you ready to learn about verbs? Verbs are action words that tell us what someone or something is doing!",
//               style: TextStyle(fontSize: 24.0, color: Colors.blue),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "For example, think about what you do: run, jump, play, laugh!",
//               style: TextStyle(fontSize: 24.0, color: Colors.green),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Verbs make our sentences exciting and full of action!",
//               style: TextStyle(fontSize: 24.0, color: Colors.purple),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               "Here are some examples of verbs:",
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               "1. Run: I run fast.",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "2. Jump: The rabbit jumps high.",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "3. Play: We play in the park.",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//             Text(
//               "4. Laugh: She laughs when she's happy.",
//               style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Verb1 extends StatelessWidget {
  const Verb1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Learn Verbs"),
      ),
      body: Swiper(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            switch(index) {
              case 0:
                return VerbIntroduction();
              case 1:
                return VerbDefinition();
              case 2:
                return VerbExample1();
              case 3:
                return VerbExample2();
              case 4:
                return VerbExample3();
              case 5:
                return VerbExample4();
              default:
                return Container();
            }
          },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class VerbIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "🌟 Let's Learn Verbs! 🌟",
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class VerbDefinition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Verbs are action words that tell us what someone or something is doing!",
                //"For example, think about what you do: run, jump, play, laugh!""Verbs make our sentences exciting and full of action!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class VerbExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Here are some examples of verbs:",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Run: I run fast.",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )
    );
  }
}

class VerbExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            "Jump: The rabbit jumps high.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
    );
  }
}

class VerbExample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            "Play: We play in the park.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
    );
  }
}

class VerbExample4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            "Laugh: She laughs when she's happy.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
    );
  }
}
