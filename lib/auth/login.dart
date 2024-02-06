import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/home1.dart';
import 'package:game/auth/register.dart';
import 'package:game/category2/home2.dart';
import 'package:game/category3/home3.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isPassword = true;

  Future<void>login()async{
    if(formkey.currentState!.validate()){
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
      Map<String, dynamic>? userdata = userdoc.data() as Map<String, dynamic>?;
      if(userdata!=null && userdata.containsKey("selectedcategory")){
        String selectedage = userdata["selectedcategory"];
      }

      String selectedage = userdoc["selectedcategory"];
      String username = userdoc['uname'];
      String useremail = userdoc['email'];

      if(selectedage!=null){
        switch(selectedage){
          case '2-3':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1(username: username, email: useremail)));
            break;

          case '4-5':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home2(username: username, email: useremail)));
            break;

          case '6-10':
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home3(username: username, email: useremail,)));
            break;

          default:
            break;
        }
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:${e}")));
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
            crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
                  return null;
                },
              ),

              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                login();
              }, child: Text("Login")),

              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
              }, child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
