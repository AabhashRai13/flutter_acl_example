import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Member'),
      ),
      body:const Center(
        child: Text('Signed In. Role: Member'),
      ),
    );
  }
}
