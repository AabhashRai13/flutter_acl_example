import 'package:acl_demo/core/shared_preference_manager.dart';
import 'package:acl_demo/question_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer' as log;
import 'core/injector.dart';

import 'screens/nav_wrapper.dart';



void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(PreLauncher());
  } catch (error, stacktrace) {
    log.log('$error & $stacktrace');
  }
}

class PreLauncher extends StatelessWidget {
  final SharedPreferencesManager sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  PreLauncher({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(userMail: sharedPreferencesManager.getString("email")??""),
        ),
      ],
      child:const MaterialApp(
        title: 'RBAC',
        debugShowCheckedModeBanner: false,
        home: NavWrapper(),
      ),
    );
  }
}
