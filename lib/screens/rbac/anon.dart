import 'package:flutter/material.dart';

class AnonScreen extends StatelessWidget {
  const AnonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous'),
      ),
      body: const Center(
        child: Text('You are not signed in.'),
      ),
    );
  }
}
