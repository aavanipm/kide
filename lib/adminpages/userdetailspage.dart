import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/adminpages/usergamesdetails.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await FirebaseFirestore.instance
          .collection('users')
          .get();
      if (users.docs.isNotEmpty) {
        setState(() {
          _users = users.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        });
      }
    } catch (error) {
      print(error); // Log the error for debugging
      // Handle errors gracefully, e.g., show a snackbar to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home"),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: _users.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Table(
            border: TableBorder.all(color: Colors.grey), // Add a border
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: [
                  _buildTableHeader('UID'),
                  _buildTableHeader('Username'),
                  _buildTableHeader('Email'),
                  _buildTableHeader('Selected Age Category'),
                  _buildTableHeader('Subscribed Category'),
                  _buildTableHeader('Games'), // New header for games
                ],
              ),
              ..._users.map((user) => _createUserTableRow(user)).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TableRow _createUserTableRow(Map<String, dynamic> user) {
    return TableRow(
      children: [
        TableCell(child: Text(user['userId'] ?? '')),
        TableCell(child: Text(user['username'] ?? '')),
        TableCell(child: Text(user['email'] ?? '')),
        TableCell(child: Text(user['selectedAgeCategory'] ?? '')),
        TableCell(child: Text(user['subscribedCategory'] ?? '')),
        // New TableCell for games with navigation functionality
        TableCell(
          child: TextButton(
            onPressed: () => _navigateToUserGames(user['userId']),
            child: Text('Games'),
          ),
        ),
      ],
    );
  }

  void _navigateToUserGames(String userId) {
    final user = FirebaseAuth.instance.currentUser; // Get current user
    if (user != null) {
      // Use user.uid for navigation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserGamesPage(userId: userId),
        ),
      );
    } else {
      // Handle the scenario where no user is signed in (optional)
    }
  }
}
