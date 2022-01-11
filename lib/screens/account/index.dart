import 'package:acl_demo/core/injector.dart';
import 'package:acl_demo/core/shared_preference_manager.dart';
import 'package:acl_demo/question_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/authenticate.dart';

class AccountScreen extends StatelessWidget {
  final SharedPreferencesManager sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  signInSignOutTile(context),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  signInSignOutTile(context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          final user = state.email;

          if (user == "") {
            return ListTile(
              title: const Text('Sign In or Sign Up'),
              leading: const Icon(Icons.login),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const Authenticate()),
                );
              },
            );
          } else {
            return ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Sign Out',
              ),
              onTap: () {
                BlocProvider.of<AuthCubit>(context).signOut();
              },
            );
          }
        });
  }
}
