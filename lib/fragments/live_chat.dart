import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class LiveChatPage extends StatefulWidget {
  @override
  LiveChatState createState() => new LiveChatState();
}

class LiveChatState extends State<LiveChatPage> {
  @override
  void initState() {
    super.initState();
    launchWhatsapp();
  }

  launchWhatsapp() async {
    await launch(
//               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
        "https://wa.me/+917977763205?text=Hi");
  }

  _makeSmsRequest() async {
    // make GET request
    String phoneno="9082768200";
    String msgText="Welcome to Kaamkhoj. We are pleased to receive your inquiry and look forward to serve you in future.\nPlease contact us on the below given numbers.\nThanks\nAlisha Rai\nCustomer Loyalty Executive\n02266661314/ 02266661323/ 02266661515\nWhatsapp 8879392064";
    String url = 'http://103.233.79.246//submitsms.jsp?user=Fitzone&key=97a7a78c99XX&mobile='+phoneno+'&message='+msgText+'&senderid=INFOSM&accusage=1';
    Response response = await get(url);
  }

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
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ButtonTheme(
                height: 40,
                minWidth: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {
                        launchWhatsapp();
//                        _makeSmsRequest();
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
          ),
          body:  Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        child: Text('KaamKhoj',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 35,
                                fontWeight: FontWeight.bold))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/logo.png")),
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                          child: Text(
                            'Thank You \n',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
