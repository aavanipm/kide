import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/adminpages/adminmainhome.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isPassword = true;

  Future<void> login() async {
    if (formkey.currentState!.validate()) {
      try {
        // Check if the user is an admin
        if (email.text == 'admin' && password.text == '1234') {
          // Admin login
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminMainPage()));
        } else {
          // Regular user login
          // Proceed with user authentication logic
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email.text)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            var userdata = querySnapshot.docs.first.data();

            UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: email.text, // corrected: use email.text instead of userdata['email']
              password: password.text,
            );

            // Check if 'email' field exists in userdata before accessing it
            if (userdata.containsKey('email')) {
              String userEmail = userdata['email']; // corrected: change 'email.text' to 'userdata['email']'

              DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userEmail) // corrected: change 'email.text' to 'userEmail'
                  .get();

              Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

              if (userData != null && userData.containsKey("selectedAgeCategory") && userData.containsKey("subscribedCategory")) {
                String selectedAge = userData["selectedAgeCategory"];
                String subscribedCategory = userData["subscribedCategory"];

                late Widget homePage;
                if (selectedAge == '2' || selectedAge == '3') {
                  homePage = Home1(
                    username: userDoc['username'],
                    email: userEmail,
                    age: selectedAge,
                    subscribedCategory: subscribedCategory,
                  );
                } else if (selectedAge == '4' || selectedAge == '5') {
                  homePage = Home2(
                    username: userDoc['username'],
                    email: userEmail,
                    age: selectedAge,
                    subscribedCategory: subscribedCategory,
                  );
                } else {
                  homePage = Home3(
                    username: userDoc['username'],
                    email: userEmail,
                    age: selectedAge,
                    subscribedCategory: subscribedCategory,
                  );
                }

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage));

                if (subscribedCategory == 'basic' ||
                    subscribedCategory == 'standard' ||
                    subscribedCategory == 'none') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Unlock More Levels"),
                        content: Text("Subscribe to access additional game levels and challenges."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubscriptionDemoPage(
                                    username: userDoc['username'],
                                    email: userEmail,
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
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User data missing selected age category")));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("User data does not contain email")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User not found")));
          }
        }
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is incorrect")));
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
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email.';
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
