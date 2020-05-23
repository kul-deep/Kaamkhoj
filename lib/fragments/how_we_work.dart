import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowWeWorkPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage("assets/images/background.png"),
      fit: BoxFit.cover
            )
          ),
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[_buildTitle(),_column()]
          ),
        ),
      ),
    ) ;
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('How we Work?',style: font1),
    ),);
  }
  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Text('An employer has to first create a login and password at www..co.in and then fill up the employer registration form after which our call centre will get in touch with you. An employer can also call us on 022-66661314 from anywhere in the world and connect directly with our call centre. For further information we also have a FAQ section on our website.',style: font2,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(top:10),),
        Center(
        child: Text('Value we deliver',style: font1),),
        Container(margin: EdgeInsets.only(bottom: 10),),
        Text('• A complete professional approach.',style: font2,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10)),
        Text('• Sense of responsibility and care.',style: font2,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10)),
        Text('• Affordable charges and Multiple payment Options.',style: font2,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10)),
        Text('• Hassle free replacement-Sound management team.',style: font2,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10)),
        Text('• 24 x 7 call centre support.',style: font2,textAlign: TextAlign.justify),
      ]
    )
    );
  }
}
