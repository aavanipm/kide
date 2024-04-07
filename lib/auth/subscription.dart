import 'package:flutter/material.dart';
import 'package:game/auth/basic plan.dart';
import 'package:game/auth/premium plan.dart';
import 'package:game/auth/standard plan.dart';

class SubscriptionDemoPage extends StatelessWidget {
  final String username;
  final String email;
  final String age;
  final String subscribedCategory; // New field to store subscribed category

  const SubscriptionDemoPage({
    Key? key,
    required this.username,
    required this.email,
    required this.age,
    required this.subscribedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool basicAvailable = false;
    bool standardAvailable = false;
    bool premiumAvailable = false;

    // Use nested if statements to correctly set availability flags
    if (subscribedCategory == "premium") {
      basicAvailable = false;
      standardAvailable = false;
      premiumAvailable = false;
    }
    else if (subscribedCategory == "basic") {
      standardAvailable = true;
      premiumAvailable = true;
    } else if (subscribedCategory == "standard") {
      premiumAvailable = true;
    } else {
      basicAvailable = true;
      standardAvailable = true;
      premiumAvailable = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subscribedCategory),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubscriptionCard(
              title: 'Basic Plan',
              price: '₹50',
              description: 'Access to basic features and levels',
              color: subscribedCategory == "basic" ? Colors.yellow.shade500 : (basicAvailable ? null : Colors.grey),
              onPressed: basicAvailable ? () {
                _navigateToPlan(context, BasicPlan(
                  username: username,
                  email: email,
                  age: age,
                  subscribedCategory: subscribedCategory,
                ));
              } : null,
            ),
            SizedBox(height: 20),
            SubscriptionCard(
              title: 'Standard Plan',
              price: '₹100',
              description: 'Access to standard features and levels',
              color: subscribedCategory == "standard" ? Colors.yellow.shade500 : (standardAvailable ? null : Colors.grey),
              onPressed: standardAvailable ? () {
                _navigateToPlan(context, StandardPlan(
                  username: username,
                  email: email,
                  age: age,
                  subscribedCategory: subscribedCategory,
                ));
              } : null,
            ),
            SizedBox(height: 20),
            SubscriptionCard(
              title: 'Premium Plan',
              price: '₹150',
              description: 'Access to premium features and all levels',
              color: subscribedCategory == "premium" ? Colors.yellow.shade500 : (premiumAvailable ? null : Colors.grey),
              onPressed: premiumAvailable ? () {
                _navigateToPlan(context, PremiumPlan(
                  username: username,
                  email: email,
                  age: age,
                  subscribedCategory: subscribedCategory,
                ));
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPlan(BuildContext context, Widget planWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => planWidget),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final VoidCallback? onPressed; // Make onPressed nullable
  final Color? color; // New field for specifying the color

  const SubscriptionCard({
    required this.title,
    required this.price,
    required this.description,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: color, // Apply the specified color
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: Text(
              price,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
