import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('HomePage View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Welcome to home page'),
      ),
    );
  }
}
