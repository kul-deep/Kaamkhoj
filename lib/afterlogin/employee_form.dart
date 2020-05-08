import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeForm1 extends StatelessWidget{

  String work;

  EmployeeForm1(String work){
    this.work=work;
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: SafeArea(
          child : Center(
 
          child:Radiobutton(work),
 
          )
        )
      ),
    );
  }
}
 
class Radiobutton extends StatefulWidget {
  String work;

  Radiobutton(String work){
    this.work=work;
  }
  @override
  RadioButtonWidget createState() => RadioButtonWidget(work);
}
 
class RadioButtonWidget extends State {
 
  String radioItemGender = '';
  String radioItemHrs = '';
  String radioItemReligion = '';
  String radioItemAge = '';

  String work;

  RadioButtonWidget(String work){
    this.work=work;
  }


  void createRecord() async {
    final databaseReference = Firestore.instance;

//        QuerySnapshot querySnapshot = await Firestore.instance.collection("Employer").getDocuments();
//    var list = querySnapshot.documents;
//    print(list.length);


    await databaseReference.collection("Employee").document("+919594976005")
        .setData({
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
          children: <Widget>[
            Text('Gender',textAlign: TextAlign.left,),
            RadioListTile(
                groupValue: radioItemGender,
                title: Text('Male'),
                value: 'Male',
                onChanged: (val) {
                  setState(() {
                    radioItemGender = val;
                  });
                },
              ),
 
             RadioListTile(
                groupValue: radioItemGender,
                title: Text('Female'),
                value: 'Female',
                onChanged: (val) {
                  setState(() {
                    radioItemGender = val;
                  });
                },
              ),
              Text('Select hours'),
              RadioListTile(
                groupValue: radioItemHrs,
                title: Text('4 hours'),
                value: '4 hours',
                onChanged: (val) {
                  setState(() {
                    radioItemHrs = val;
                  });
                },
              ),
 
             RadioListTile(
                groupValue: radioItemHrs,
                title: Text('8 hours'),
                value: '8 hours',
                onChanged: (val) {
                  setState(() {
                    radioItemHrs = val;
                  });
                },
              ),
               RadioListTile(
                groupValue: radioItemHrs,
                title: Text('12 hours'),
                value: '12 hours',
                onChanged: (val) {
                  setState(() {
                    radioItemHrs = val;
                  });
                },
              ),
 
             RadioListTile(
                groupValue: radioItemHrs,
                title: Text('24 hours'),
                value: '24 hours',
                onChanged: (val) {
                  setState(() {
                    radioItemHrs = val;
                  });
                },
              ), 
              Text('Select Religion'),
              RadioListTile(
                groupValue: radioItemReligion,
                title: Text('Hindu'),
                value: 'Hindu',
                onChanged: (val) {
                  setState(() {
                    radioItemReligion = val;
                  });
                },
              ),
 
             RadioListTile(
                groupValue: radioItemReligion,
                title: Text('Muslim'),
                value: 'Muslim',
                onChanged: (val) {
                  setState(() {
                    radioItemReligion = val;
                  });
                },
              ),
               RadioListTile(
                groupValue: radioItemReligion,
                title: Text('Christian'),
                value: 'Christian',
                onChanged: (val) {
                  setState(() {
                    radioItemReligion = val;
                  });
                },
              ),
              Text('Age'),
              RadioListTile(
                groupValue: radioItemAge,
                title: Text('18-30'),
                value: '18-30',
                onChanged: (val) {
                  setState(() {
                    radioItemAge = val;
                  });
                },
              ),
 
             RadioListTile(
                groupValue: radioItemAge,
                title: Text('30-40'),
                value: '30-40',
                onChanged: (val) {
                  setState(() {
                    radioItemAge = val;
                  });
                },
              ),
               RadioListTile(
                groupValue: radioItemAge,
                title: Text('40 & above'),
                value: '40 & above',
                onChanged: (val) {
                  setState(() {
                    radioItemAge = val;
                  });
                },
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
