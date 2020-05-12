// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeForm extends StatelessWidget{

  String work;
  String phoneNo;

  EmployeeForm(String work,String phoneNo){
    this.work=work;
    this.phoneNo=phoneNo;
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: Container(
          margin: EdgeInsets.all(16),
          child: SafeArea(
            
            child:Radiobutton(work,phoneNo),
          ),
        )
      ),
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


     await databaseReference.collection("Employee").document(phoneNo)
         .updateData({
       'Gender': radioItemGender,
       'Hrs': radioItemHrs,
       'Religion': radioItemReligion,
       'Age': radioItemAge,
       'Work': work,
     });
   }


  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            
            Text('Gender',style: TextStyle(fontSize: 20),),

            new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("Male"),
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
                  new Text("Female"),


                ],
              ),
            ),
            Text('Select Hours',style: TextStyle(fontSize: 20),),

            new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("4 Hours"),
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
                  new Text("8 Hours"),
                  


                ],
              ),
            ),
             new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("12 Hours"),
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
                  new Text("24 Hours"),
                ],
              ),
             ),
             Text('Select Religion',style: TextStyle(fontSize: 20),),

            new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("Hindu"),
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
                  new Text("Christian"),
                  


                ],
              ),
            ),
             new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("Muslim"),
                  ),

                  // new Radio(
                  //   groupValue: radioItemReligion,
                  //   value: 'All',
                  //   onChanged: (val) {
                  //     setState(() {
                  //       radioItemReligion = val;
                  //     });
                  //   },
                  // ),
                  // new Text("All"),
                ],
              ),
                       
             ),
             Text('Employee Age',style: TextStyle(fontSize: 20),),

            new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("18-30"),
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
                  new Text("31-40"),
                  


                ],
              ),
            ),
             new Container(margin: EdgeInsets.only(left: 10),
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
                  new Container(margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                  constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
                  child:                  
                  new Text("40 & above"),
                  ),

                  // new Radio(
                  //   groupValue: radioItemReligion,
                  //   value: 'All',
                  //   onChanged: (val) {
                  //     setState(() {
                  //       radioItemReligion = val;
                  //     });
                  //   },
                  // ),
                  // new Text("All"),
                ],
              ),
                       
             ),
              
             
             

           
          Container(
          height: 40,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
          children: <Widget>[
           
           Expanded(
             child: GestureDetector(
                    onTap: (){
//                      print(radioItemGender);
//                      print(radioItemHrs);
//                      print(radioItemReligion);
//                      print(radioItemAge);
                       createRecord();
                    },
                    child: Container(

                      alignment: Alignment.center,
                      color: Colors.blue[300],
                      child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18)),

                    ),
                  ),
           ),

            //  Text('$radioItem', style: TextStyle(fontSize: 23),)
            
          ],
      ),
    )]));
  }
}