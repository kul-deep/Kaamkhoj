import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
class HowWeWorkPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
  var font3 = GoogleFonts.sourceSansPro(
                      color: Colors.blue[300],
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
  }
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: SafeArea(
            child: Scaffold(
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
        RichText(
          textAlign: TextAlign.justify,
  text: TextSpan(
    text: 'An employer has to first create a login and password at',
    style: font2,
    children: <TextSpan>[
      TextSpan(text: ' kaamkhoj.co.in',style: font3),
      TextSpan(text: ' and then fill up the employer registration form after which our call centre will get in touch with you. An employer can also call us on'),
      TextSpan(text: ' 022-66661314',style: font3),
      TextSpan(text: ' from anywhere in the world and connect directly with our call centre. For further information we also have a FAQ section on our website.', style:font2),
    ],
  ),
),
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
