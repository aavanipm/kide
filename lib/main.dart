import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game/Home/home.dart';
import 'package:game/category1/home1.dart';
import 'package:game/firebase_options.dart';
import 'package:game/auth/login.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: Home1(username: "kk", email: "kkk", age: "2",),
        home: Login(),
      ),
    );
  }
}
