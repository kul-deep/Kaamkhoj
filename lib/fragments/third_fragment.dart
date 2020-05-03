import 'package:flutter/material.dart';

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[_buildTitle(),_column()]
        ),
      ),
    ) ;
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('How we Work?',style: TextStyle(color :Colors.red,fontSize: 25)),
    ),);
  }
  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Text('An employer has to first create a login and password at www..co.in and then fill up the employer registration form after which our call centre will get in touch with you. An employer can also call us on 022-66661314 from anywhere in the world and connect directly with our call centre. For further information we also have a FAQ section on our website.'),
        Container(margin: EdgeInsets.only(top:10),),
        Center(
        child: Text('Value we deliver',style: TextStyle(color :Colors.red,fontSize: 25),textAlign: TextAlign.center,),),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• A complete professional approach.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Sense of responsibility and care.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Affordable charges and Multiple payment Options.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Hassle free replacement-Sound management team.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• 24 x 7 call centre support.'),
      ]
    )
    );
  }
}
