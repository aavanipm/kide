// import 'package:flutter/material.dart';
// import 'package:learningapp/Home/homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Authentication Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder<bool>(
//         future: AuthManager.isUserLoggedIn(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Or any other loading indicator
//           }
//           if (snapshot.data == true) {
//             return HomePage();
//           } else {
//             return LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             String authToken = AuthManager.generateAuthToken();
//             await AuthManager.saveAuthToken(authToken);
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           },
//           child: Text('Login'),
//         ),
//       ),
//     );
//   }
// }
//
//
// class AuthManager {
//   static const String authTokenKey = 'authToken';
//
//   static Future<void> saveAuthToken(String authToken) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(authTokenKey, authToken);
//   }
//
//   static Future<String?> getAuthToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(authTokenKey);
//   }
//
//   static Future<void> clearAuthToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(authTokenKey);
//   }
//
//   static Future<bool> isUserLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? authToken = prefs.getString(authTokenKey);
//     return authToken != null;
//   }
//
//   static String generateAuthToken() {
//
//     return 'random_auth_token';
//   }
// }