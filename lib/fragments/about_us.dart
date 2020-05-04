// import 'package:flutter/material.dart';

// class SecondFragment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Center(
//       child: new Text("Hello Fragment 2"),
//     );
//   }

// }
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget{
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
    return Container(margin: EdgeInsets.only(top:10),
    child: Center(
      child: Text('About Us',style: TextStyle(color :Colors.red,fontSize: 25)),
    ),);
  }

  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Text('Misson',style: TextStyle(color :Colors.red,fontSize: 25),),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('Our mission is to provide you with a service experience unmatched by any other organisation.'),
        Container(margin: EdgeInsets.only(top:10),),
        Text('Vision',style: TextStyle(color :Colors.red,fontSize: 25),textAlign: TextAlign.left,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('Our vision is to be the most competent and innovative organization by making the difference through our people, that consists of a team of dedicated professionals who value their customers, deliver on their promises and contribute to sustainable development.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('Our Endeavour',style: TextStyle(color :Colors.red,fontSize: 25),textAlign: TextAlign.left,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Complete solution under one roof.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Creating value for our clients.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Well trained and experienced Customer Care Staff.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Professional approach.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Using technology to create proximity between the Employer\'s and Employee\'s work place.'),
      ]
    )
    );
  }
}