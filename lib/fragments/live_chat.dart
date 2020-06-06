import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';



class LiveChatPage extends StatefulWidget {
  @override
  LiveChatState createState() => new LiveChatState();
}

class LiveChatState extends State<LiveChatPage> {



  @override
  void initState()  {
    super.initState();
    launchWhatsapp();

  }
  launchWhatsapp() async {
  await launch(
//               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
  "https://wa.me/+917977763205?text=Hello");}
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
              backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
              bottomNavigationBar: Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child:
                ButtonTheme(
          height: 40,
          minWidth: 290,
          child: Align(
            alignment: Alignment.center,
            child: RaisedButton(
                onPressed: () {
                        launchWhatsapp();


                  // valid();
                  // sformKey.currentState.();
                  // verifyPhone();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Chat Again',
                  style: GoogleFonts.karla(
                      color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                textColor: Colors.white,
                elevation: 7,
                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
          ),
        ),
                           ),
          body: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/upper.png")),
                  )),
                  Column(
                    children: <Widget>[
                      Text('Thank You',
                      style: GoogleFonts.sourceSansPro(
                                  color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                  fontSize: 40,
                                  ),
                      ),
                      
                                        
                    ],
                  ),
              ],
            ),
            
          ),
        ),
      ),
    );
  
  }

}