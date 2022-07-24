import 'package:app_search_title/src/view/desgin/shared/constants.dart';
import 'package:app_search_title/src/view/desgin/shared/loading.dart';
import 'package:app_search_title/src/viewmodel/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String? email;
  String? password;
  String? confirmPassword;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign up to App'),
              actions: <Widget>[
                TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Sign in'))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 40),
                          const Text(
                            "Create accout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            onSaved: (newValue) => password = newValue,
                            validator: (String? value) {
                              if (value!.length < 6) {
                                return "Enter a password 6+ chars long";
                              }
                              return null;
                            },
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Confirm password'),
                            onSaved: (newValue) => confirmPassword = newValue,
                            validator: (String? value) {
                              if (password != value) {
                                return "Password does't match";
                              }
                              return null;
                            },
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email!, password!);
                                  if (result == null) {
                                    setState(() {
                                      error = 'please supply a valid email';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink[400], // background
                                onPrimary:
                                    Colors.white, // foreground // mau chu
                              ),
                              child: const Text(
                                'Register',
                                // style: TextStyle(color: Colors.white),
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
                        ],
                      ),
                    ))));
  }
}
