import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/AjouterClient.dart';
import 'package:plantylogin/ChoisirPlante.dart';

import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';
import 'package:plantylogin/login.dart';



class AdminAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Admin Access'),backgroundColor:kPrimaryColor
        ),
        body: Admin(),

      ),
    );
  }
}

class Admin  extends StatefulWidget{
  @override
  AdminWidget createState() => AdminWidget();
}
class AdminWidget extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.logout),
        tooltip: 'Logout',
        backgroundColor: kPrimaryColor,

        onPressed: () {
          AuthenticationHelper()
              .signOut()
              .then((_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (contex) => Login()),
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Center(
        child :
        Column(children: <Widget>[
          SizedBox(height: 100),
          ElevatedButton(

            onPressed: () {
              // Respond to button press
             // gotoSecondActivity(context);

            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)))),
            child: Text(
              'Visualiser',
              style: TextStyle(fontSize: 18),
            ),
          ),

          SizedBox(height: 30),


          ElevatedButton(

            onPressed: () {
              // Respond to button press
              // gotoSecondActivity(context);

            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)))),
            child: Text(
              'Modifier Client',
              style: TextStyle(fontSize: 18),
            ),
          ),

          SizedBox(height: 30),


          ElevatedButton(

            onPressed: () {
              // Respond to button press
              Navigator.pushReplacement(context,
                  MaterialPageRoute(
                      builder: (context) => AjouterClient()));
            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)))),
            child: Text(
              'Ajouter Client',
              style: TextStyle(fontSize: 18),
            ),
          ),

          SizedBox(height: 30),

          ElevatedButton(

            onPressed: () {
              // Respond to button press
              // gotoSecondActivity(context);

            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)))),
            child: Text(
              'Supprimer Client',
              style: TextStyle(fontSize: 18),
            ),
          ),

                  ])

    ),


    );

  }


  }