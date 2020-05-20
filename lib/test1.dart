//import 'package:flutter/material.dart';
//
//class LogoutPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Center(
//      child: new Text("Hello Fragment 2"),
//    );
//  }
//
//}

// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget{
//   createState(){
//     return LoginScreenState();
//   }
// }
// class LoginScreenState extends State<LoginScreen>{
//   final formKey = GlobalKey<FormState>();
//   Widget build(context){
//     return Container(
//       margin: EdgeInsets.all(20.0),
//       child: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             emailField(),
//             passwordField(),
//             Container(margin: EdgeInsets.only(top: 25)),
//             submitButton(),
//           ],
//         ),
//         ),

//     );
//   }
// Widget emailField(){
//   return TextFormField(
//     keyboardType: TextInputType.emailAddress,
//     decoration: InputDecoration(
//       labelText: 'Email address',
//       hintText: 'you@example.com',
//     ),
//     validator: (String value){
//       if (!value.contains('@')){
//       return 'Please enter valid email address';
//       }
//     },
//     onSaved: (String value){
//       print(value);
//     },
//   );

// }
// Widget passwordField(){
//   return TextFormField(
//     obscureText: true,
//     decoration: InputDecoration(
//       labelText: 'Password',
//       hintText: 'pass',
//       ),
//       validator: (String value){
//         if (value.length<4){
//           return 'must contain atleast 4 char';
//         }
//       },
//       onSaved: (String value){
//       print(value);
//     },
//   );

// }
// Widget submitButton(){
//   return RaisedButton(
//     color: Colors.blue,
//     child: Text('submit'),
//     onPressed: () {
//       if (formKey.currentState.validate()){
//         formKey.currentState.save();
//       }
//     },
//   );
// }

// }
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

// import 'package:kaamkhoj/homepage.dart';

class TestPage1 extends StatefulWidget {
  String type;

  TestPage1(String type) {
    this.type = type;
  }

  @override
  _TestPageState createState() => _TestPageState(type);
}

class _TestPageState extends State<TestPage1> {
  final formKey = GlobalKey<FormState>();
  String phoneNo = "", password = "";
  String errorMobile = '';
  String errorPass = 'Aditya';
  String type;

  // final databaseReference = Firestore.instance;

  String errorMessage = '';

  _TestPageState(String type) {
    this.type = type;
    print("Login as " + type);
  }

  void valid() {
    if ((phoneNo == "") || (password == "")) {
      String errorblank = "Please fill this field";

      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
        });
      }
      if (password == "") {
        setState(() {
          errorPass = errorblank;
        });
      }

      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorMobile == "" && errorPass == "") {
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  void verify() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

    // DocumentReference documentReference =
    // databaseReference.collection(type).document(phoneNo);
    // documentReference.get().then((d

    //Datasnapshot) {
    //   if (datasnapshot.exists) {
    //     print(datasnapshot.data['password'].toString());
    //     if(password==datasnapshot.data['password'].toString()){
    //       print("Right Password");
    //       SignIn();
    //     }
    //     else{
    //       errorMessage="Wrong Credentials";
    //       print("Wrong credentials");
    //     }
    //   }
    //   else {
    //     print("No such user");
    //   }
    // });
  }

  void SignIn() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7e9e9),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/combined.jpg"),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  // color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                  width: 290,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder:  new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        filled: true,
                        fillColor: Colors.white70,
                        // labelText: 'Mobile Number',
                        hintText: 'Mobile Number'),
                    onChanged: (value) {
                      this.phoneNo = "+91" + value;
                      // valid();
                      if (value.length < 10) {
                        setState(() {
                          errorMobile = "Mobile number contains 10 digits";
                        });
                      } else {
                        setState(() {
                          errorMobile = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorMobile != ''
                ? Text(
                    errorMobile,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  // color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                  width: 290,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                  ),
                    borderSide: BorderSide(
                      color: Colors.white70,
                    )),
                  enabledBorder:  new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        filled: true,
                        fillColor: Colors.white70,
                        // jfcontentPadding: new EdgeInsets.symmetric(horizontal: 10.0),
                        // labelText: 'Password',
                        hintText: 'Password'),
                    onChanged: (value) {
                      this.password = value;
                      // valid();
                      if (value.length < 6) {
                        setState(() {
                          errorPass =
                              "Password must contain atleast 6 characters";
                        });
                      } else {
                        setState(() {
                          errorPass = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorPass != ''
                ? Text(
                    errorPass,
  
                style: TextStyle(color: Colors.red),
                  )
                : Container(
              padding: EdgeInsets.all(50),
            )),
            SizedBox(
              height: 10,
              width: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    onPressed: () {
                      valid();
                      // verify();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Submit'),
                    textColor: Colors.white,
                    elevation: 7,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b))),
          ],
        ),
      ),
    );
  }
}
