import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/ChoisirPlante.dart';
import 'package:plantylogin/ModifierPlante.dart';

import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';
import 'package:plantylogin/login.dart';



class InfoPlante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Info Plante'),backgroundColor:kPrimaryColor
        ),
        body: Info(),

      ),
    );
  }
}

class Info  extends StatefulWidget{
  @override
  InfoWidget createState() => InfoWidget();
}
class InfoWidget extends State {

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
                MaterialPageRoute(builder: (context) => ChoisirPlante()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body:
      Center(
        child :

        Column(children: <Widget>[

          SizedBox(height: 100),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(250, 50),
                maximumSize: const Size(300, 50),
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
              'Tableau de bord',
              style: TextStyle( fontSize: 18),
            ),
          ),
          SizedBox(height: 35),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(250, 50),
                maximumSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        24.0)))),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ModifierPlante()));
            },
            child: Text(
              'Paramétrage de la plante',
              style: TextStyle( fontSize: 18),
            ),
          ),
          SizedBox(height: 35),
          ElevatedButton(

            onPressed: () {
              // Respond to button press
              gotoSecondActivity(context);

            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(250, 50),
                maximumSize: const Size(300, 50),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)))),
            child: Text(
              'Valider',
              style: TextStyle(fontSize: 18),
            ),
          ),


        ]),


      )

    );




  }
  gotoSecondActivity(BuildContext context){

     Navigator.push(
     context,
    MaterialPageRoute(builder: (context) => ChoisirPlante()),
     );

  }
}
