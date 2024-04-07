import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/register.dart';
import 'package:game/auth/subscription.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';
import 'package:game/category3/home3.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isPassword = true;

  Future<void> login() async {
    if (formkey.currentState!.validate()) {
      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username.text)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userdata = querySnapshot.docs.first.data();

          UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: userdata['email'],
            password: password.text,
          );

          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(username.text)
              .get();

          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey("selectedAgeCategory") && userData.containsKey("subscribedCategory")) {
            String selectedAge = userData["selectedAgeCategory"];
            String subscribedCategory = userData["subscribedCategory"];

            Widget homePage;
            if (selectedAge == '2' || selectedAge == '3') {
              homePage = Home1(username: userDoc['username'], email: userdata['email'], age: selectedAge, subscribedCategory: subscribedCategory);
            } else if (selectedAge == '4' || selectedAge == '5') {
              homePage = Home2(username: userDoc['username'], email: userdata['email'], age: selectedAge, subscribedCategory: subscribedCategory);
            } else {
              homePage = Home3(username: userDoc['username'], email: userdata['email'], age: selectedAge, subscribedCategory: subscribedCategory);
            }

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage));
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Need a subscription"),
                  content: Text("Need a plan"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionDemoPage(
                              username: userDoc['username'],
                              email: userdata['email'],
                              age: selectedAge,
                              subscribedCategory: subscribedCategory,
                            ),
                          ),
                        );
                      },
                      child: Text("Go to subscription"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User data missing selected age category")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User not found")));
        }
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.message}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid username.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: password,
                obscureText: isPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(isPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text("Login"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
