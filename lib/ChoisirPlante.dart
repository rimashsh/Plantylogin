import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/InfoPlante.dart';

import 'package:plantylogin/authentication.dart';
import 'package:plantylogin/home.dart';
import 'package:plantylogin/ForgotPassword.dart';

import 'package:plantylogin/constants.dart';
import 'package:plantylogin/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() => runApp(ChoisirPlante());

class ChoisirPlante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Choisir Plante'),backgroundColor:kPrimaryColor
        ),

        body: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var planteList;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('planteList: $planteList');
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

      body: Column(
        children: [
          SizedBox(height: 60),

           Text("Saisie une plante",


              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold, fontSize: 19
              )

          ),
          SizedBox(height: 30),

          Expanded(

           flex: 0,
            child:

            Center(
              child:
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Plante')
                    .orderBy('name')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    planteList = snapshot.data!.docs[0].get('name');
                    debugPrint('setDefault make: $planteList');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: planteList,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: kPrimaryColor,
                    ),
                    items: snapshot.data!.docs.map((value) {
                      return DropdownMenuItem(
                        value: value.get('name'),
                        child: Text('${value.get('name')}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('selected onchange: $value');
                      setState(
                            () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          planteList = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                          // Set makeModel to true to display first car from list
                          setDefaultMakeModel = true;
                        },
                      );
                    },
                  );

                },
              ),


            ),
          ),
          SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),
                primary: kPrimaryColor,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        24.0)))),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => InfoPlante()));
            },
            child: Text(
              'Valider',
              style: TextStyle( fontSize: 18),
            ),
          ),
          SizedBox(height: 35),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                maximumSize: const Size(200, 50),
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
              'Ajouter une plante',
              style: TextStyle( fontSize: 18),
            ),
          ),



        ],


      ),

    );

  }
}