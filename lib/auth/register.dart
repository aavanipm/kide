import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game/auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController uname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final formkey = GlobalKey<FormState>();
  String? selectedcategory;
  bool isPassword = true;

  Future<void>save()async{
    if(formkey.currentState!.validate()){
      try{
        final existinguser = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email.text).get();
        if(existinguser.docs.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists")));
        }
        final existingusername = await FirebaseFirestore.instance.collection('users').where('uname', isEqualTo: uname.text).get();
        if(existingusername.docs.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username already exists")));
        }
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email' : email.text,
          'password' : password.text,
          'uname' : uname.text,
          'selectedcategory': selectedcategory,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Successfully")));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFormField(
                controller: uname,
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Enter Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Please enter a value";
                  }
                },
              ),
              SizedBox(height: 20,),

              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email address.';
                  }
                  if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller: password,
                obscureText: isPassword,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Password",
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                        icon: Icon(isPassword?Icons.visibility: Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (value.length < 8 || !RegExp(r'[0-9]').hasMatch(value) || !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                    return 'Password should contain a minimum of 8 characters, \n one number, and one special character.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),

              DropdownButtonFormField(
                hint: Text("Select age"),
                value: selectedcategory,
                  items: ["2-3","4-5","6-10"].map<DropdownMenuItem<String>>((String value) =>
                      DropdownMenuItem(
                          value: value,

                          child: Text(value))).toList(),
                  onChanged: (String? value){
                  setState(() {
                    selectedcategory = value;
                  });
              },validator: (value){
                  if(value==null || value.isEmpty){
                    return "Please select an option";
                  }
              },),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                save();
              }, child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}

