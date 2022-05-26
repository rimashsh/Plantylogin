import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantylogin/ConfirmEmail.dart';
import 'package:plantylogin/ForgotPassword.dart';
import 'package:plantylogin/home.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter auth Demo',

      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        ConfirmEmail.id: (context) => ConfirmEmail(message: '',),
        ForgotPassword.id: (context) => ForgotPassword(),
      },
      home: Login(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}
 /* class AddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  backgroundColor: Colors.green,
  title: Text("geeksforgeeks"),
  ),
  body:Center(
  child: FloatingActionButton(
  backgroundColor: Colors.green,
  child: Icon(Icons.add),
  onPressed: () {
  FirebaseFirestore.instance
      .collection('Plante')
      .add({'name': 'data added through app'});
  },
  ),
  ),
  );
  }*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var carMake, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('carMake: $carMake');
    debugPrint('carMakeModel: $carMakeModel');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
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
                    carMake = snapshot.data!.docs[0].get('name');
                    debugPrint('setDefault make: $carMake');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: carMake,
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
                          carMake = value;
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

        ],
      ),
    );
  }
}


