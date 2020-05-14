// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:kaamkhoj/homepage.dart';
// import 'package:kaamkhoj/test/employer_form.dart';

class RegisterPage extends StatefulWidget {
  String type;
  RegisterPage(String type){
    this.type=type;
    print("Register as "+type);
  }

  @override
  _RegisterPageState createState() => _RegisterPageState(type);
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String phoneNo="",name="",email="",password="",city="";
  // final databaseReference = Firestore.instance;
  String errorName='';
  String errorEmail='';
  String errorMobile='';
  String errorPass='';
  String errorCity='';
  String smsOTP,type;
  String verificationId;
  String errorMessage = '';
  // FirebaseAuth _auth = FirebaseAuth.instance;

  _RegisterPageState(String type){
    this.type=type;
    print("Register as "+type);
  }
  void valid(){
    if ((name=="" ) || (email=="") || (phoneNo=="") || (password=="") || (city=="")){
                         String errorblank="Please fill this field";
                       if (name==""){
                         setState((){
                           errorName=errorblank;
                         });
                       }
                       if (email==""){
                         setState((){
                           errorEmail=errorblank;
                         });
                       }
                       if (phoneNo==""){
                         setState((){
                           errorMobile=errorblank;
                         });
                       }
                       if (password==""){
                         setState((){
                           errorPass=errorblank;
                         });
                       }
                       if (city==""){
                         setState((){
                           errorCity=errorblank;
                         });
                       }
                       Toast.show("Please fill all the fields", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                     
                     }
                     else 
                     {
                         if (errorName=="" && errorEmail=="" && errorMobile=="" && errorPass=="" && errorCity==""){
                          
                       }
                       else {
                          Toast.show("Please fill all the fields correctly", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                       }
                     

                     
                  }

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
      body: Center(
        child: SingleChildScrollView(
                  child: Form(
            key: formKey,
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Full Name'),
                    onChanged: (value) {
                      this.name = value;
                      // valid();
                      Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(name)){
                            setState(() {
                          errorName = "Invalid Username";
                        });
                      }
                      else{
                        setState(() {
                          errorName = "";
                        });

                      }
                       
                    },
                    // validator: (name){
                    //     Pattern pattern =
                    //         r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    //     RegExp regex = new RegExp(pattern);
                    //     if (!regex.hasMatch(name))
                    //       return 'Invalid username';
                    //     else
                    //       return null;

                    //   },
                    //    onSaved: (String value){
                    //        print(value);
                    //         },
                  ),
                ),
                (errorName != ''
                    ? Text(
                  errorName,
                  style: TextStyle(color: Colors.red),
                )
                    : Container()),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email ID'),
                    onChanged: (value) {
                      this.email = value;
                      // valid();
                      if(EmailValidator.validate(value)){
                         setState(() {
                          errorEmail = "";
                        });
                      }
                      else{
                         setState(() {
                          errorEmail = "Invalid Email Address";
                        });
                      }
                    },
                    // validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                      // onSaved: (email)=> _email = email,
                  ),
                ),
                (errorEmail != ''
                    ? Text(
                  errorEmail,
                  style: TextStyle(color: Colors.red),
                )
                    : Container()),
                SizedBox(
                  height: 10,
                ), Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Mobile No.'),
                    onChanged: (value) {

                      this.phoneNo = "+91"+value;
                      // valid();
                      if(value.length<10){
                        setState(() {
                          errorMobile = "Mobile number contains 10 digits";
                        });
                      }
                      else{
                        setState(() {
                          errorMobile = "";
                        });

                      }
                    },
                  //   validator: (String value){
                  //     if(value.length<10){
                  //       return 'Mobile contains 10 digits';
                  //     }
                  // },
                  // onSaved: (String value){
                  //          print("+91"+value);
                  //       },
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
                ), Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password (minimum 6 characters)'),
                    onChanged: (value) {
                      this.password = value;
                      // valid();
                      if(value.length<6){
                         setState(() {
                          errorPass = "Password must contain atleast 6 characters";
                        });
                      }
                      else{
                        setState(() {
                          errorPass = "";
                        });

                      }

                      
                    },
                  
                  ),
                ),
                (errorPass != ''
                    ? Text(
                  errorPass,
                  style: TextStyle(color: Colors.red),
                )
                    : Container()),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'City'),
                    onChanged: (value) {
                      this.city = value;
                      // valid();
                      Pattern pattern =
                              r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(city)){
                         setState(() {
                          errorCity = "Invalid city name";
                        });
                      }
                      else{
                        setState(() {
                          errorCity = "";
                        });

                      }
                    },
                    // validator: (city){
                    //       Pattern pattern =
                    //           r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    //       RegExp regex = new RegExp(pattern);
                    //       if (!regex.hasMatch(city))
                    //         return 'Invalid city name';
                    //       else
                    //         return null;

                    //     },
                    //  onSaved: (String value){
                    //        print(value);
                    //         },    
                  ),
                ),
                (errorCity != ''
                    ? Text(
                  errorCity,
                  style: TextStyle(color: Colors.red),
                )
                    : Container()),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                     valid();
                          // sformKey.currentState.();
                    // verifyPhone();
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
      ),
    );
  
}
}