import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/ChoisirPlante.dart';
import 'package:plantylogin/InfoPlante.dart';

import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';
import 'package:plantylogin/login.dart';



class ModifierPlante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Modifier Plante'),backgroundColor:kPrimaryColor
        ),
        body: Modifier(),

      ),
    );
  }
}

class Modifier  extends StatefulWidget{
  @override
  ModifierWidget createState() => ModifierWidget();
}
class ModifierWidget extends State {

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
              MaterialPageRoute(builder: (context) => InfoPlante()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Center(

        child :
        Column(children: <Widget>[

          SizedBox(height: 50),

          new Container
            (
              child:Row(
                  children:<Widget>[
                    Spacer(),

                    SizedBox(
                      height: 30,
                      width: 120,
                      child: Text("Température",


                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold, fontSize: 19
                          )

                      ),
                    ),
                    Spacer(),

                    SizedBox(
                      height: 40,
                      width: 270,
                      child:     TextField(
                        decoration: InputDecoration(

                            hintText: 'Enter Température',

                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (value) {
                          // do something
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 40),

          new Container
            (
              child:Row(
                  children:<Widget>[
                    Spacer(),

                    SizedBox(
                      height: 30,
                      width: 120,
                      child: Text("Humidité",


                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold, fontSize: 19
                          )

                      ),
                    ),
                    Spacer(),

                    SizedBox(
                      height: 40,
                      width: 270,
                      child:TextField(
                        decoration: InputDecoration(

                            hintText: 'Enter Humidité',

                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (value) {
                          // do something
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 30),

          new Container
            (
              child:Row(
                  children:<Widget>[
                    Spacer(),

                    SizedBox(
                      height: 30,
                      width: 120,
                      child: Text("Longueur",


                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold, fontSize: 19
                          )

                      ),
                    ),
                    Spacer(),

                    SizedBox(
                      height: 40,
                      width: 270,
                      child:     TextField(
                        decoration: InputDecoration(

                            hintText: 'Enter Longueur',

                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (value) {
                          // do something
                        },
                      ),
                    ),
                  ])
          ),
          SizedBox(height: 50),

          ElevatedButton(

                        onPressed: () {
                          // Respond to button press
                          gotoSecondActivity(context);

                        },
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            minimumSize: const Size(150, 50),
                            maximumSize: const Size(150, 50),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(24.0)))),
                        child: Text(
                          'Valider',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

        ]),
      ),



    );


  }
  gotoSecondActivity(BuildContext context){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChoisirPlante()),
    );

  }
}