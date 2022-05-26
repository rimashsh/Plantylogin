import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/AdminAccess.dart';
import 'package:plantylogin/ChoisirPlante.dart';
import 'package:plantylogin/DatabaseService.dart';
import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';

class Login extends StatelessWidget {
  static String id = 'sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Stack(
        children: [
          // Lets add some decorations
          Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kPrimaryColor
                ),
              )
          ),

          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kPrimaryColor
                ),
              )
          ),


          // logo

             LoginForm(),

        ],
      ),
    );
  }

}



class LoginForm extends StatefulWidget {


 // final bool isLogin;
  //final Duration animationDuration;

  //LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Align(
        alignment: Alignment.center,
        child: Container(
        //width: size.width,
       // height: defaultLoginSize,
        child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80),

          Image.asset('assets/images/bgg.png'),
          SizedBox(height: 30),

          // email
          TextFormField(
            // initialValue: 'Input text',
            //textAlign: TextAlign.center,

            decoration: InputDecoration(

              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',

              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),
          SizedBox(
            height: 20,
          ),

          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Password',

              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: _obscureText,
            onSaved: (val) {
              password = val;

            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),




          SizedBox(height: 30),


          SizedBox(
            height: 54,
            width: 184,
            child:


            ElevatedButton(
              onPressed: () async {
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //var firebaseUser = await FirebaseAuth.instance.currentUser!;
                  var user = await FirebaseAuth.instance.currentUser;

                  AuthenticationHelper()
                      .signIn(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {

                         getUserDoc();

                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          24.0)))),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
            ),


          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        24.0)))),
            onPressed: () {
              Navigator.pushNamed(
                context,
                ForgotPassword.id,
              );
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle( fontSize: 12),
            ),
          ),
        ],
      ),
    )
        )
    )
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    print("Admin"==uid);
    return uid;
    //print(uemail);
  }
  Future<void> getUserDoc() {
    // Initiate an auth instance
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Initiate a firebase firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // Create a current user object
    User user = _auth.currentUser!;
    if(user.uid=="WEHQZ4aYCFMoxkaB9yJVObDi1pY2") {
      // Create a document reference based on the 'users'
      DocumentReference ref = _firestore.collection('admin').doc(user.uid);
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => AdminAccess()));
      // Return a collection that sets/updates the following data
      // based on the user.uid
      return ref.set({
        'UID': user.uid,
        'Email': user.email,
        'CreatedUserAt': user.metadata.creationTime,
        'LastSignInAt': user.metadata.lastSignInTime,
        'EmailVerified': user.emailVerified,
      });


    }else{
      DocumentReference ref = _firestore.collection('users').doc(user.uid);
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => ChoisirPlante()));
      // Return a collection that sets/updates the following data
      // based on the user.uid
      return ref.set({
        'UID': user.uid,
        'Email': user.email,
        'CreatedUserAt': user.metadata.creationTime,
        'LastSignInAt': user.metadata.lastSignInTime,
        'EmailVerified': user.emailVerified,
      });

    }
  }


}
