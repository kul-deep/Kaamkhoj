import 'package:flutter/material.dart';

class Contact_us extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
           children: <Widget>[_buildTitle(),_column()]
        ))
      );
      
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:20),
    child: Center(
      child: Text('Contact Info',style: TextStyle(color :Colors.red,fontSize: 25)),
    ),);
  }

  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Text('Registered Office : 54, Mamta \'A\' wing, A.M. Marg, Prabhadevi, Mumbai- 400 025.'),
        Container(margin: EdgeInsets.only(top:10),),
        Text('Telephone : 022-66661314 / 022-66661414.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('WhatsApp : 08879392064'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('Email : customercare@kaamkhoj.co.in'),
                
      ]
    )
    );
  }
}