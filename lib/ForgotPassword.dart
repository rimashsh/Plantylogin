import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantylogin/ConfirmEmail.dart';
import 'package:plantylogin/constants.dart';


class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String _email;

  _passwordReset() async {
    try {
      _formKey.currentState?.save();
      final user = await _auth.sendPasswordResetEmail(email: _email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(message: widget.message,);
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:kPrimaryColor ,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail!;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              24.0)))),
                child: Text('Send Email'),
                onPressed: () {
                  _passwordReset();
                  print(_email);
                }

              ),
              ElevatedButton(
                child: Text('Sign In'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}