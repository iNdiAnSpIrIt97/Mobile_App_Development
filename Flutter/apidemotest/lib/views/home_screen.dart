// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    print('Fetching users..........');
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("fetch users completed");
  }
}
