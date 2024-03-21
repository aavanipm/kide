// subscription page                                                                                                                                                     import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SubscriptionDemoPage extends StatelessWidget {
  const SubscriptionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Subscription Plan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SubscriptionPlanCard(
                      price: '₹50',
                      details: 'Unlock some levels',
                      onPressed: () {
                      },
                    ),
                    const SizedBox(height: 20),
                    SubscriptionPlanCard(
                      price: '₹100',
                      details: 'Unlock all levels',
                      onPressed: () {
                      },
                    ),
                    SubscriptionPlanCard(
                        price: '₹150',
                        details: 'Unlock all levels',
                        onPressed: (){

                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final String price;
  final String details;
  final VoidCallback onPressed;

  const SubscriptionPlanCard({
    required this.price,
    required this.details,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              Text(
                'Price: $price',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Details:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                details,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Subscribe Now'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}