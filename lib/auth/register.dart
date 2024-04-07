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
                  labelText: 'Username',
                  hintText: 'Enter Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
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
        // Check if username already exists
        bool isUsernameTaken = await isUsernameAlreadyTaken(_unameController.text);
        if (isUsernameTaken) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username is already taken')),
          );
          return;
        }

        // Register user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Save user data
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_unameController.text)
            .set({
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
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<bool> isUsernameAlreadyTaken(String username) async {
    // Check if the username already exists in the database
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}


// old register
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:game/auth/login.dart';
//
// class Register extends StatefulWidget {
//   const Register({super.key});
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//
//   TextEditingController _unameController=TextEditingController();
//   TextEditingController _emailController=TextEditingController();
//   TextEditingController _passwordController=TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String? selectedcategory;
//   bool isPassword = true;
//
//   Future<void> save() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final existingUser = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _emailController.text)
//             .get();
//         if (existingUser.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists")));
//           return;
//         }
//         final existingUsername = await FirebaseFirestore.instance.collection('users').doc(_unameController.text).get();
//         // Check if document with username exists
//         if (existingUsername.exists) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username already exists")));
//           return;
//         }
//
//         UserCredential userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//             email: _emailController.text,
//             password: _passwordController.text);
//
//         // Check that the data is saved with the correct field names to Firestore
//         await FirebaseFirestore.instance.collection('users').doc(_unameController.text).set({
//           'uname': _unameController.text,
//           'email': _emailController.text,
//           'password': _passwordController.text,
//           'selectedAgeCategory': selectedcategory, // Ensure correct field name here
//         });
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Registered successfully")));
// // Ensure that navigation after successful registration directs to the login page
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//
//       } catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Error: $e")));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               TextFormField(
//                 controller: _unameController,
//                 decoration: InputDecoration(
//                     labelText: "Username",
//                     hintText: "Enter Username",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)
//                     )
//                 ),
//                 validator: (value){
//                   if(value==null || value.isEmpty){
//                     return "Please enter a value";
//                   }
//                 },
//               ),
//               SizedBox(height: 20,),
//
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   hintText: "Enter Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(50)
//                   )
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a valid email address.';
//                   }
//                   if (!RegExp(
//                       r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//                       .hasMatch(value)) {
//                     return 'Please enter a valid email address.';
//                   }
//                   return null;
//                 },
//               ),
//
//               SizedBox(height: 20,),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: isPassword,
//                 decoration: InputDecoration(
//                     labelText: "Password",
//                     hintText: "Enter Password",
//                     suffixIcon: IconButton(onPressed: (){
//                       setState(() {
//                         isPassword = !isPassword;
//                       });
//                     },
//                         icon: Icon(isPassword?Icons.visibility: Icons.visibility_off)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)
//                     )
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a valid value.';
//                   }
//                   if (value.length < 8 || !RegExp(r'[0-9]').hasMatch(value) || !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
//                     return 'Password should contain a minimum of 8 characters, \n one number, and one special character.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20,),
//
//               DropdownButtonFormField(
//                 hint: Text("Select age"),
//                 value: selectedcategory,
//                   items: ["2-3","4-5","6-10"].map<DropdownMenuItem<String>>((String value) =>
//                       DropdownMenuItem(
//                           value: value,
//
//                           child: Text(value))).toList(),
//                   onChanged: (String? value){
//                   setState(() {
//                     selectedcategory = value;
//                   });
//               },validator: (value){
//                   if(value==null || value.isEmpty){
//                     return "Please select an option";
//                   }
//               },),
//               SizedBox(height: 10,),
//               ElevatedButton(onPressed: (){
//                 save();
//               }, child: Text("Register"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

