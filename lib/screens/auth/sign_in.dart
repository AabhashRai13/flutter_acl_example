import 'package:acl_demo/question_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_exception.dart';
import '../../widgets/loading.dart';

class SignInWrapper extends StatelessWidget {
  final Function? toggleView;
  const SignInWrapper({
    Key? key,
    this.toggleView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 2,
        title: const Text(
          'Authenticating',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: (size.width > 600 && size.height > 520)
          ? SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 480,
                    height: 380,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: SignIn(toggleView!),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: SignIn(toggleView!),
            ),
    );
  }
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn(this.toggleView, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign In',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text('Use your Email Address'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofillHints: const [AutofillHints.email],
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() => loading = true);
                              dynamic status =
                                  BlocProvider.of<AuthCubit>(context)
                                      .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              if (status != AuthResultStatus.successful) {
                                setState(() => loading = false);
                                final errorMsg = AuthExceptionHandler
                                    .generateExceptionMessage(status);
                                _showAlertDialog(errorMsg);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Text(error),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 32.0,
                    // alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: const Text(
                          'Join Us - it\'s Free',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:const Text(
              'Sign In Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }
}
