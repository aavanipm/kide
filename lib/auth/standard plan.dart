import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/category1/home1.dart';
import 'package:game/category2/home2.dart';

class StandardPlan extends StatefulWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory;

  const StandardPlan({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  _StandardPlanState createState() => _StandardPlanState();
}

class _StandardPlanState extends State<StandardPlan> {
  final _cardHolderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectExpiryDate(context);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showPaymentConfirmation();
                    }
                  },
                  child: Text('Pay 149'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime
          .now()
          .year + 10),
    );
    if (picked != null) {
      setState(() {
        _expiryDateController.text = picked.toString().substring(0, 10);
      });
    }
  }
  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure to make the payment?'),
          content: Text('This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Save plan type and update subscribed category to Firebase Firestore
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.email) // Assuming email is unique
                      .update({
                    'subscribedCategory': 'standard', // Update subscribed category
                  });
                  _navigate(widget.age);
                } catch (e) {
                  print('Error updating plan type and subscribed category: $e');
                }
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _navigate(String age) async {
    int ageInt = int.tryParse(age) ?? 0; // Convert age to an integer

    if (ageInt == 2 || ageInt == 3 || ageInt == 4 || ageInt == 5) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home1(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: 'standard', // Update subscribed category
          ),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home2(
            username: widget.username,
            email: widget.email,
            age: widget.age,
            subscribedCategory: 'standard', // Update subscribed category
          ),
        ),
      );
    }
  }
}
