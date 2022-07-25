import 'package:app_search_title/src/view/desgin/components/custom_surfix_icon.dart';
import 'package:app_search_title/src/view/desgin/components/socal_card.dart';
import 'package:app_search_title/src/view/desgin/shared/constants.dart';
import 'package:app_search_title/src/view/desgin/shared/loading.dart';
import 'package:app_search_title/src/viewmodel/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        const Text(
                          "Welcome",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //
                        const SizedBox(
                          height: 20,
                        ),
                        _textfieldEmail(),
                        const SizedBox(
                          height: 20,
                        ),
                        _textFieldPassword(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buttonSignIn(),
                        _buttonCreateAccout(),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        _buttonServiceLogin(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _textfieldEmail() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        hintText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
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
    );
  }

  Widget _textFieldPassword() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        hintText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
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
    );
  }

  Widget _buttonSignIn() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            dynamic result =
                await _auth.signInWithEmailAndPassword(email, password);
            if (result == null) {
              setState(() {
                loading = false;
                error = 'cloud not sign in with those cedentials';
              });
            }
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.pink[400], // background
          onPrimary: Colors.white, // foreground // mau chu
        ),
        child: const Text(
          'Sign in',
          // style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buttonCreateAccout() {
    return TextButton(
        onPressed: () {
          widget.toggleView();
        },
        style: TextButton.styleFrom(
          primary: Colors.black54,
          textStyle: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
        ),
        child: const Text(
          'Create accout',
          textAlign: TextAlign.center,
        ));
  }

  Widget _buttonServiceLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocalCard(
          icon: "assets/icons/google-icon.svg",
          press: () {},
        ),
        SocalCard(
          icon: "assets/icons/facebook-2.svg",
          press: () {},
        ),
        SocalCard(
          icon: "assets/icons/twitter.svg",
          press: () {},
        ),
      ],
    );
  }
}
