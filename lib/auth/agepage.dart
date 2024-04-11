import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';
import 'package:game/category3/home3.dart';

class AgePage extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const AgePage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  late String _selectedAgeCategory;

  @override
  void initState() {
    super.initState();
    _selectedAgeCategory = widget.age;
  }

  void _saveAgeToFirebase() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference usersCollection = firestore.collection('users');

      QuerySnapshot<Object?> querySnapshot = await usersCollection.where('username', isEqualTo: widget.username).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        await userDocRef.update({
          'selectedAgeCategory': _selectedAgeCategory,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Age updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User document not found')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Your Age"),
        backgroundColor: Colors.green.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: _selectedAgeCategory,
              onChanged: (value) {
                setState(() {
                  _selectedAgeCategory = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Age Category',
                border: OutlineInputBorder(),
              ),
              items: ['2', '3', '4', '5', '6', '7', '8', '9', '10']
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _saveAgeToFirebase();

                if (_selectedAgeCategory == '2' || _selectedAgeCategory == '3') {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home1(
                        username: widget.username,
                        email: widget.email,
                        age: _selectedAgeCategory,
                        subscribedCategory: widget.subscribedCategory,
                      ),
                    ),
                  );
                } else if (_selectedAgeCategory == '4' || _selectedAgeCategory == '5') {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home2(
                        username: widget.username,
                        email: widget.email,
                        age: _selectedAgeCategory,
                        subscribedCategory: widget.subscribedCategory,
                      ),
                    ),
                  );
                } else {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home3(
                        username: widget.username,
                        email: widget.email,
                        age: _selectedAgeCategory,
                        subscribedCategory: widget.subscribedCategory,
                      ),
                    ),
                  );
                }
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
