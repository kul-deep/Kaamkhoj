
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFragment extends StatelessWidget {
  var font1 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
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
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
         decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage("assets/images/Background.png"),
      fit: BoxFit.cover
            )
          ),
        child: SingleChildScrollView(
                  child: Column(
             children: <Widget>[_carousel(),_column()]
          ),
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
        child: Text('Welcome !',style: GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 24,
                      fontWeight: FontWeight.bold))),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in is a professionally managed manpower portal which caters to the requirements of "Blue Collar" workers all over the world. Today most manpower agencies promise you the moon in the beginning, but never receive your calls after the payment formalities are completed. As far as .co.in is a concern, we stick to our promises and commitment, and always keep the expectations of our customer, as our TOP PRIORITY.',textAlign: TextAlign.justify,style: font1),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• We even offer you a 24 x 7 fully equipped, well-trained customer care department that will attend to all your needs at any time. We are using technology at its best we have developed certain algorithms that cater to the employer\'s requirements from the area where the employer has the requirement.',textAlign: TextAlign.justify,style: font1),
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