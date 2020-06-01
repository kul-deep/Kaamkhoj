import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TestPageState();
}

LoginData(){

}

class _TestPageState extends State<TestPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';


  void createRecord() async {
    final databaseReference = Firestore.instance;

    await databaseReference.collection("test")
        .document("Aditya")
        .updateData({"Aditya":FieldValue.arrayUnion([{"Aditya":"9594976005","Maker":"Aditya"}])});

//        .setData({
//      'email' : email,
//      'password' : password,
//    });
  }



  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
          child: new Scaffold(
        body: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: this._formKey,
              child: new ListView(
                children: <Widget>[
                  new TextFormField(
                      onChanged: (value) {
                        this.email = value;
                      },
                      keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address'
                      )
                  ),
                  new TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        this.password = value;
                      },// Use secure text for passwords.
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password'
                      )
                  ),
                  new Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new Text(
                        'Login',
                        style: new TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
//                      print(email+" "+password);
                       createRecord();
                      },
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}