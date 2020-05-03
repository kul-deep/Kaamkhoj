import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Register.dart';
import 'choosetype.dart';
import 'homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
//  runApp( ChooseType("login"),);
  runApp( ChooseType("register"),);
}

class MyApp1 extends StatelessWidget {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Phone',
        home:Scaffold(
      appBar: AppBar(
        title: Text('FireStore Demo'),
      ),
      body: Center(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),
              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Update Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  print("done");
                  deleteData();
                },
              ),
            ],
          )), //center
    )
    );
  }

  void createRecord() async {
    print("done");
    await databaseReference.collection("employee")
        .document("Aditya")
        .setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

//    DocumentReference ref = await databaseReference.collection("books")
//        .add({
//      'title': 'Flutter in Action',
//      'description': 'Complete Programming Guide to learn Flutter'
//    });
//    print(ref.documentID);
  }

  void getData() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

    DocumentReference documentReference =
    databaseReference.collection("employee").document("Aditya");
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
       print(datasnapshot.data.toString());
      }
      else {
        print("No such user");
      }
    });

  }

  void updateData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference
          .collection('books')
          .document('Aditya')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}


//void main() => runApp(MyApp());
//
  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Authentication',
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
        '/loginpage': (BuildContext context) => MyApp(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage('Phone Authentication'),
    );
  }
}
