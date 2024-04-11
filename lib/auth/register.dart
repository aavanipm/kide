import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/auth/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  String? _selectedAgeCategory;
  bool _isPasswordVisible = false;
  String _subscribedCategory = 'none';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter child name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedAgeCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedAgeCategory = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Age Category',
                ),
                items: ['2','3','4','5','6','7','8','9','10']
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an age category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // // Check if username already exists
        // bool isUsernameTaken = await isUsernameAlreadyTaken(_unameController.text);
        // if (isUsernameTaken) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Username is already taken')),
        //   );
        //   return;
        // }

        // Register user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Get the user ID
        String userId = userCredential.user!.uid;

        // Save user data with user ID
        await FirebaseFirestore.instance.collection('users')
            .doc(_emailController.text)
            .set({
          'userId': userId,
          'username': _unameController.text,
          'email': _emailController.text,
          'selectedAgeCategory': _selectedAgeCategory,
          'subscribedCategory': _subscribedCategory,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter another email.')),
        );
      }
    }
  }
  // Future<bool> isUsernameAlreadyTaken(String username) async {
  //   // Check if the username already exists in the database
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: _emailController.text)
  //       .get();
  //
  //   return querySnapshot.docs.isNotEmpty;
  // }
}
