import 'package:flutter/material.dart';

import 'account/index.dart';
import 'rbac/admin.dart';

class AdminWrapper extends StatefulWidget {
  const AdminWrapper({Key? key}) : super(key: key);

  @override
  _AdminWrapperState createState() => _AdminWrapperState();
}

class _AdminWrapperState extends State<AdminWrapper> {
  int _selectedPage = 0;
  final _pageOptions = [
  const  AdminScreen(),
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
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
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
