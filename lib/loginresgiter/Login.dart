 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:kaamkhoj/homepage.dart';


class LoginPage extends StatefulWidget {

  String type;

  LoginPage(String type){
    this.type=type;
  }

  @override
  _LoginPageState createState() => _LoginPageState(type);
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String phoneNo,password,type;
   final databaseReference = Firestore.instance;

  String errorMessage = '';

  _LoginPageState(String type){
    this.type=type;
    print("Login as "+type);
  }




  void verify() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

     DocumentReference documentReference =
     databaseReference.collection(type).document(phoneNo);
     documentReference.get().then((datasnapshot) {
       if (datasnapshot.exists) {
         if(password==datasnapshot.data['password'].toString()){
           print("Right Password");
           SignIn();
         }
         else{
           errorMessage="Wrong Credentials";
           print("Wrong credentials");
         }
       }
       else {
         print("No such user");
       }
     });
  }


  void SignIn(){
    print("Done");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomePage()),
    // );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Form(
          key: formKey,
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(                  
                  keyboardType: TextInputType.phone,                  
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter 10 digit number'),
                  onChanged: (value) {
                    this.phoneNo = "+91"+value;
                  },
                   validator: (String value){
                    if(value.length<10){
                      return 'Mobile contains 10 digits';
                    }
                },
                onSaved: (String value){
                         print("+91"+value);
                      },
                ),
              ),
              SizedBox(
                height: 10,
              ), Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'minimum 6 digits'),
                  onChanged: (value) {
                    this.password = value;
                  },
                  validator: (String value){
                    if(value.length<6){
                      return 'Password must contain atleast 6 characters';
                    }
                  
                },
                onSaved: (String value){
                         print(value);
                          },
                ),
              ),
              (errorMessage != ''
                  ? Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              )
                  : Container()),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                   if (formKey.currentState.validate()){
                        formKey.currentState.save();
                    }
                   verify();
                },
                child: Text('Verify'),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
