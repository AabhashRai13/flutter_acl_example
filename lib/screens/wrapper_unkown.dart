import 'package:flutter/material.dart';

import 'account/index.dart';
import 'rbac/anon.dart';

class AnonWrapper extends StatefulWidget {
  const AnonWrapper({Key? key}) : super(key: key);

  @override
  _AnonWrapperState createState() => _AnonWrapperState();
}

class _AnonWrapperState extends State<AnonWrapper> {
  int _selectedPage = 0;
  final _pageOptions = [
   const AnonScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.masks),
            label: 'Anonymous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
