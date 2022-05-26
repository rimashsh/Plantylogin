import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/AdminAccess.dart';
import 'package:plantylogin/ChoisirPlante.dart';
import 'package:plantylogin/ConfirmEmail.dart';

import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';
import 'package:plantylogin/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AjouterClient extends StatelessWidget {
  final String message =
      "An email has just been sent to you, Click the link provided to complete registration";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ajouter Client'),backgroundColor:kPrimaryColor
        ),
        body: Ajouter(),

      ),
    );
  }
}

class Ajouter extends StatefulWidget{
  @override
  AjouterWidget createState() => AjouterWidget();
}
class AjouterWidget extends State {
   late String email;
   late String nom;

   late String password;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(

        label: Text("Retour",   style: new TextStyle(fontSize: 18
        ),),

        backgroundColor: kPrimaryColor,

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                100.0))),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminAccess()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Center(
        child:
        Column(children: <Widget>[
          SizedBox(height: 50),

          new Container
            (
              child: Row(
                  children: <Widget>[
                    Spacer(),

                    SizedBox(
                      height: 20,
                      width: 120,
                      child: Text("Nom",

                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold, fontSize: 19,
                          )


                      ),

                    ),
                    //Spacer(),

                    SizedBox(
                      height: 60,
                      width: 270,
                      child: TextFormField(
                        // initialValue: 'Input text',
                        //textAlign: TextAlign.center,
                        onChanged: (value) => nom = value,

                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.account_circle_sharp),
                          labelText: 'Nom',

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
                          nom = val!;
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 40),

          new Container

            (
              child: Row(
                  children: <Widget>[
                    Spacer(),

                    SizedBox(
                      height: 20,
                      width: 120,
                      child: Text("Email",


                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold, fontSize: 19
                          )

                      ),
                    ),

                    SizedBox(
                      height: 60,
                      width: 270,
                      child:
                      // email
                      TextFormField(
                        // initialValue: 'Input text',
                        //textAlign: TextAlign.center,
                        onChanged: (value) => email = value,

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
                          email = val!;
                          print("Emmaaaail"==email);
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 30),

          new Container
            (
              child: Row(
                  children: <Widget>[
                    Spacer(),

                    SizedBox(
                      height: 20,
                      width: 120,
                      child: Text("Mot de Passe",


                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold, fontSize: 19
                          )

                      ),
                    ),
                    Spacer(),

                    SizedBox(
                      height: 60,
                      width: 270,
                      child:
                      // email
                      TextFormField(
                        // initialValue: 'Input text',
                        //textAlign: TextAlign.center,
                        onChanged: (value) => password = value,

                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.lock),
                          labelText: 'password',

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
                          password = val!;
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 50),


        ElevatedButton(

                        onPressed: ()  {
                          Fluttertoast.showToast(
                            msg: "Client ajouté avec succès",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.lightGreen,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                          getUserDoc();

                          }
                          ,
                          style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                              minimumSize: const Size(150, 50),
                              maximumSize: const Size(150, 50),

                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                          24.0)))),
                          child: Text(
                          'Valider',
                          style: TextStyle(fontSize: 18),
                          ),
                           ),



        ]),
      ),


    );
  }

  Future<void> getUserDoc() {
    AuthenticationHelper()
        .signUp(email: email, password: password)
        .then((result) {
      if (result == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home()));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
    // Initiate an auth instance
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Initiate a firebase firestore instance
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;



    // Create a current user object
    User user = _auth.currentUser!;
      DocumentReference ref = _firestore.collection('users').doc(user.uid);
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => AdminAccess()));
      // Return a collection that sets/updates the following data
      // based on the user.uid
      return ref.set({
        'UID': user.uid,
        'Nom': nom,
        'Email': email,

      //  'PassWord': user.updatePassword(newPassword)
      });

    }


  }





