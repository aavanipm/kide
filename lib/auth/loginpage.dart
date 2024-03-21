// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:game/auth/register.dart';
// import 'package:game/category1/home1.dart';
// import 'package:game/category2/home2.dart';
// import 'package:game/category3/home3.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   final formkey = GlobalKey<FormState>();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   bool isPassword = true;
//
//   Future<void> login() async {
//     if (formkey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await auth.signInWithEmailAndPassword(
//           email: username.text,
//           password: password.text,
//         );
//
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .get();
//         Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
//
//         if (userData != null && userData.containsKey("selectedAgeCategory")) {
//           String selectedAge = userData["selectedAgeCategory"];
//
//           switch (selectedAge) {
//             case '2':
//             case '3':
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Home1(
//                   username: userDoc['username'], email: userDoc['email'], age: selectedAge)));
//               break;
//             case '4':
//             case '5':
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Home2(
//                   username: userDoc['username'], email: userDoc['email'], age: selectedAge)));
//               break;
//             case '6':
//             case '7':
//             case '8':
//             case '9':
//             case '10':
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Home3(
//                 username: userDoc['username'], email: userDoc['email'],)));
//               break;
//             default:
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid age category")));
//               break;
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User data not found or missing age category")));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: formkey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: username,
//                 decoration: InputDecoration(
//                     labelText: "Username",
//                     hintText: "Enter Username",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)
//                     )
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a valid username.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20,),
//               TextFormField(
//                 controller: password,
//                 obscureText: isPassword,
//                 decoration: InputDecoration(
//                     labelText: "Password",
//                     hintText: "Enter Password",
//                     suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isPassword = !isPassword;
//                           });
//                         },
//                         icon: Icon(isPassword ? Icons.visibility : Icons.visibility_off)
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)
//                     )
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a valid value.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10,),
//               ElevatedButton(
//                   onPressed: () {
//                     login();
//                   },
//                   child: Text("Login")
//               ),
//               SizedBox(height: 10,),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
//                   },
//                   child: Text("Register")
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }