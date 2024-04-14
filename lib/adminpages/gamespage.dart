import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/adminpages/usergamesdetails.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await FirebaseFirestore.instance
          .collection('uploaded games')
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
        title: Text("Games"),
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
                  _buildTableHeader('ID'),
                  _buildTableHeader('Name'),
                  _buildTableHeader('Age Category'),
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
        TableCell(child: Text(user['id'] ?? '')),
        TableCell(child: Text(user['name'] ?? '')),
        TableCell(child: Text(user['age'] ?? '')),
      ],
    );
  }
}
