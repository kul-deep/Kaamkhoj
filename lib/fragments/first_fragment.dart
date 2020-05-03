
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class FirstFragment extends StatelessWidget {
  @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return new Center(
  //     child: new Text("Hello Fragment 1"),
  //   );
  // }
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
           children: <Widget>[_carousel(),_column()]
        ))
      );
      
  }
   Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Container(margin: EdgeInsets.only(top:10),),
        Center(
        child: Text('Welcome !',style: TextStyle(color :Colors.red,fontSize: 25),textAlign: TextAlign.center,),),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in is a professionally managed manpower portal which caters to the requirements of "Blue Collar" workers all over the world. Today most manpower agencies promise you the moon in the beginning, but never receive your calls after the payment formalities are completed. As far as .co.in is a concern, we stick to our promises and commitment, and always keep the expectations of our customer, as our TOP PRIORITY.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• We even offer you a 24 x 7 fully equipped, well-trained customer care department that will attend to all your needs at any time. We are using technology at its best we have developed certain algorithms that cater to the employer\'s requirements from the area where the employer has the requirement.'),
             ]
    )
    );
  }

  Widget _carousel(){
    return SizedBox(
      height: 200.0,
    width: 350.0,
    child: Carousel(
      images: [
        ExactAssetImage("assets/images/a1.jpg"),
        ExactAssetImage("assets/images/a2.jpg"),        
      ],
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.lightGreenAccent,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.purple.withOpacity(0.5),
      borderRadius: true,
      moveIndicatorFromBottom: 180.0,
      noRadiusForIndicator: true,    
      

    ));
  }





}