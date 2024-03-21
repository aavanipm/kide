import 'package:flutter/material.dart';
import 'package:game/auth/login.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';
import 'package:game/category3/home3.dart';

class LoginPage1 extends StatelessWidget {
  final String username;
  final String useremail;
  final String userage;

  LoginPage1({
    required this.username,
    required this.useremail,
    required this.userage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                agecat(context);
              },
              child: Text('Login back to $username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Login to another account'),
            ),
            // SizedBox(height: 20),
            // Text(
            //   'Created Accounts:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            // // Display created accounts
            // ListTile(
            //   title: Text('Username: $username'),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Email: $useremail'),
            //       Text('Age: $userage'),
            //     ],
            //   ),
            //   leading: Icon(Icons.account_circle),
            //   onTap: () {
            //     // Handle tapping on the account if needed
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void agecat(BuildContext context) {
    switch (userage) {
      case '2':
      case '3':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home1(username: username, email: useremail, age: userage),
          ),
        );
        break;
      case '4':
      case '5':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home2(username: username, email: useremail, age: userage),
          ),
        );
        break;
      case '6':
      case '7':
      case '8':
      case '9':
      case '10':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home3(username: username, email: useremail, age: userage,),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid age category")),
        );
        break;
    }
  }
}
