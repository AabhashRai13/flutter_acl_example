import 'package:flutter/material.dart';

import 'account/index.dart';
import 'rbac/member.dart';

class MemberWrapper extends StatefulWidget {
  const MemberWrapper({Key? key}) : super(key: key);

  @override
  _MemberWrapperState createState() => _MemberWrapperState();
}

class _MemberWrapperState extends State<MemberWrapper> {
  int _selectedPage = 0;
  final _pageOptions = [
 const  MemberScreen(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Member',
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
