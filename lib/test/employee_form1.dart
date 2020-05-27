// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/test/thankyouform.dart';

class EmployeeForm extends StatelessWidget{

  String work;
  String phoneNo;

  EmployeeForm(String work,String phoneNo){
    this.work=work;
    this.phoneNo=phoneNo;
  }

   @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child:Radiobutton(work,phoneNo),
        )
      );
  }
}
 
class Radiobutton extends StatefulWidget {
  String work,phoneNo;

  Radiobutton(String work,String phoneNo){
    this.work=work;
    this.phoneNo=phoneNo;
  }
  
  @override
  RadioButtonWidget createState() => RadioButtonWidget(work,phoneNo);
}
 
class RadioButtonWidget extends State {
 
  String radioItemGender = '';
  String radioItemHrs = '';
  String radioItemReligion = '';
  String radioItemAge = '';

  String work,phoneNo;

  RadioButtonWidget(String work,String phoneNo){
    this.work=work;
    this.phoneNo=phoneNo;
  }

   void createRecord() async {
     final databaseReference = Firestore.instance;

 //        QuerySnapshot querySnapshot = await Firestore.instance.collection("Employer").getDocuments();
 //    var list = querySnapshot.documents;
 //    print(list.length);


     await databaseReference.collection("data").document(phoneNo).collection("Employee").document("data")
         .setData({
       'Gender': radioItemGender,
       'Hrs': radioItemHrs,
       'Religion': radioItemReligion,
       'Age': radioItemAge,
       'Work': work,
     });
     Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => ThankyouPage(),
         ));
   }


  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
            child: Padding(
              padding: EdgeInsets.only(top: 60, bottom: 60, right: 23, left: 23),
              child: Container(
                padding: EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Gender',
                      style: font1,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemGender,
                          value: 'Male',
                          onChanged: (val) {
                            setState(() {
                              radioItemGender = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("Male",style: font2)
                        ),
                        new Radio(
                          groupValue: radioItemGender,
                          value: 'Female',
                          onChanged: (val) {
                            setState(() {
                              radioItemGender = val;
                            });
                          },
                        ),
                        new Text("Female",style: font2),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left:10),
                      child: Text(
                      'Select Hours',
                      style: font1,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemHrs,
                          value: '4 Hours',
                          onChanged: (val) {
                            setState(() {
                              radioItemHrs = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("4 Hours",style: font2),
                        ),
                        new Radio(
                          groupValue: radioItemHrs,
                          value: '8 Hours',
                          onChanged: (val) {
                            setState(() {
                              radioItemHrs = val;
                            });
                          },
                        ),
                        new Text("8 Hours",style: font2),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemHrs,
                          value: '12 Hours',
                          onChanged: (val) {
                            setState(() {
                              radioItemHrs = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("12 Hours",style: font2),
                        ),
                        new Radio(
                          groupValue: radioItemHrs,
                          value: '24 Hours',
                          onChanged: (val) {
                            setState(() {
                              radioItemHrs = val;
                            });
                          },
                        ),
                        new Text("24 Hours",style: font2),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Select Religion',
                      style: font1,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemReligion,
                          value: 'Hindu',
                          onChanged: (val) {
                            setState(() {
                              radioItemReligion = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("Hindu",style: font2),
                        ),
                        new Radio(
                          groupValue: radioItemReligion,
                          value: 'Christian',
                          onChanged: (val) {
                            setState(() {
                              radioItemReligion = val;
                            });
                          },
                        ),
                        new Text("Christian",style: font2),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemReligion,
                          value: 'Muslim',
                          onChanged: (val) {
                            setState(() {
                              radioItemReligion = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("Muslim",style: font2),
                        ),
//                        new Radio(
//                          groupValue: radioItemReligion,
//                          value: 'All',
//                          onChanged: (val) {
//                            setState(() {
//                              radioItemReligion = val;
//                            });
//                          },
//                        ),
//                        new Text("All"),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Employee Age',
                      style: font1,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemAge,
                          value: '18-30',
                          onChanged: (val) {
                            setState(() {
                              radioItemAge = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("18-30",style: font2),
                        ),
                        new Radio(
                          groupValue: radioItemAge,
                          value: '31-40',
                          onChanged: (val) {
                            setState(() {
                              radioItemAge = val;
                            });
                          },
                        ),
                        new Text("31-40",style: font2),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemAge,
                          value: '40 & above',
                          onChanged: (val) {
                            setState(() {
                              radioItemAge = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("40 & above",style: font2),
                        ),

//                        new Radio(
//                          groupValue: radioItemAge,
//                          value: 'All',
//                          onChanged: (val) {
//                            setState(() {
//                              radioItemAge = val;
//                            });
//                          },
//                        ),
//                        new Text("All"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonTheme(
                      height: 40,
                      minWidth: 290,
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            onPressed: () {

                                print(radioItemGender);
                                print(radioItemHrs);
                                print(radioItemReligion);
                                print(radioItemAge);
                                createRecord();
                              //  valid();
                              // sformKey.currentState.();
                              // verifyPhone();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.karla(
                                  color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            elevation: 7,
                            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                      )),
                ]),
              ),
            ),
          ),
        ));

//
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//          child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//
//          children: <Widget>[
//
//            Text('Gender',style: TextStyle(fontSize: 20),),
//
//            new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemGender,
//                    value: 'Male',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemGender = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("Male"),
//                  ),
//
//                  new Radio(
//                    groupValue: radioItemGender,
//                    value: 'Female',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemGender = val;
//                      });
//                    },
//                  ),
//                  new Text("Female"),
//
//
//                ],
//              ),
//            ),
//            Text('Select Hours',style: TextStyle(fontSize: 20),),
//
//            new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemHrs,
//                    value: '4 Hours',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemHrs = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("4 Hours"),
//                  ),
//
//                  new Radio(
//                    groupValue: radioItemHrs,
//                    value: '8 Hours',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemHrs = val;
//                      });
//                    },
//                  ),
//                  new Text("8 Hours"),
//
//
//
//                ],
//              ),
//            ),
//             new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemHrs,
//                    value: '12 Hours',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemHrs = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("12 Hours"),
//                  ),
//
//                  new Radio(
//                    groupValue: radioItemHrs,
//                    value: '24 Hours',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemHrs = val;
//                      });
//                    },
//                  ),
//                  new Text("24 Hours"),
//                ],
//              ),
//             ),
//             Text('Select Religion',style: TextStyle(fontSize: 20),),
//
//            new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemReligion,
//                    value: 'Hindu',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemReligion = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("Hindu"),
//                  ),
//
//                  new Radio(
//                    groupValue: radioItemReligion,
//                    value: 'Christian',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemReligion = val;
//                      });
//                    },
//                  ),
//                  new Text("Christian"),
//
//
//
//                ],
//              ),
//            ),
//             new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemReligion,
//                    value: 'Muslim',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemReligion = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("Muslim"),
//                  ),
//
//                  // new Radio(
//                  //   groupValue: radioItemReligion,
//                  //   value: 'All',
//                  //   onChanged: (val) {
//                  //     setState(() {
//                  //       radioItemReligion = val;
//                  //     });
//                  //   },
//                  // ),
//                  // new Text("All"),
//                ],
//              ),
//
//             ),
//             Text('Employee Age',style: TextStyle(fontSize: 20),),
//
//            new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemAge,
//                    value: '18-30',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemAge = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("18-30"),
//                  ),
//
//                  new Radio(
//                    groupValue: radioItemAge,
//                    value: '31-40',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemAge = val;
//                      });
//                    },
//                  ),
//                  new Text("31-40"),
//
//
//
//                ],
//              ),
//            ),
//             new Container(margin: EdgeInsets.only(left: 10),
//              child: new Row(
//
//                children: <Widget>[
//                  new Radio(
//                    groupValue: radioItemAge,
//                    value: '40 & above',
//                    onChanged: (val) {
//                      setState(() {
//                        radioItemAge = val;
//                      });
//                    },
//                  ),
//                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
//                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
//                  child:
//                  new Text("40 & above"),
//                  ),
//
//                  // new Radio(
//                  //   groupValue: radioItemReligion,
//                  //   value: 'All',
//                  //   onChanged: (val) {
//                  //     setState(() {
//                  //       radioItemReligion = val;
//                  //     });
//                  //   },
//                  // ),
//                  // new Text("All"),
//                ],
//              ),
//
//             ),
//
//
//
//
//
//          Container(
//          height: 40,
//          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//          child: Row(
//          children: <Widget>[
//
//           Expanded(
//             child: GestureDetector(
//                    onTap: (){
////                      print(radioItemGender);
////                      print(radioItemHrs);
////                      print(radioItemReligion);
////                      print(radioItemAge);
//                       createRecord();
//                    },
//                    child: Container(
//
//                      alignment: Alignment.center,
//                      color: Colors.blue[300],
//                      child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18)),
//
//                    ),
//                  ),
//           ),
//
//            //  Text('$radioItem', style: TextStyle(fontSize: 23),)
//
//          ],
//      ),
//    )]));
  }
}