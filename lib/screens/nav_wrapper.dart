import 'package:acl_demo/core/injector.dart';
import 'package:acl_demo/core/shared_preference_manager.dart';
import 'package:acl_demo/question_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '_wrapper_admin.dart';
import '_wrapper_anon.dart';
import '_wrapper_member.dart';

class NavWrapper extends StatefulWidget {
  const NavWrapper({Key? key}) : super(key: key);

  @override
  State<NavWrapper> createState() => _NavWrapperState();
}

class _NavWrapperState extends State<NavWrapper> {
  final SharedPreferencesManager sharedPreferencesManager =
      locator<SharedPreferencesManager>();
  _checkLogin()  {
     BlocProvider.of<AuthCubit>(context).claims;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = state.email;
        print("user $user");
        print("user ${user == ""}");
        if (user == "") {
          return AnonWrapper();
        } else {
          return const BaseWrapper();
        }
      },
    );
  }
}

class BaseWrapper extends StatelessWidget {
  const BaseWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getRole() async {
      final token = await BlocProvider.of<AuthCubit>(context).claims;
      final String? roleClaim = token;
      final String role = roleClaim ?? 'member';
      return role;
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return FutureBuilder(
          future: _getRole(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case 'member':
                return MemberWrapper();

              case 'admin':
                return AdminWrapper();

              default:
                return MemberWrapper();
            }
          },
        );
      },
    );

    // return Consumer<AuthService>(
    //   builder: (context, auth, child) {
    //     return FutureBuilder(
    //       future: _getRole(),
    //       builder: (context, snapshot) {
    //         switch (snapshot.data) {
    //           case 'member':
    //             return MemberWrapper();

    //           case 'admin':
    //             return AdminWrapper();

    //           default:
    //             return MemberWrapper();
    //         }
    //       },
    //     );
    //   },
    // );
  }
}
