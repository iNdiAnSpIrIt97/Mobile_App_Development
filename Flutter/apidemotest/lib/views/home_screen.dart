// ignore_for_file: avoid_print
import 'package:apidemotest/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:apidemotest/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

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
            return ListTile(
              title: Text(user.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.location.city),
                  Text(user.phone),
                  Text(user.location.state),
                  Text(user.location.postcode),
                ],
              ),
            );
          }),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
