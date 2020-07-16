import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/fragments/payment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PaymentScreen.dart';
import 'package:toast/toast.dart';



class PaytmPaymentPage extends StatefulWidget {
  @override
  _PaytmPaymentPageState createState() => _PaytmPaymentPageState();
}

class _PaytmPaymentPageState extends State<PaytmPaymentPage> {
  String _amount = "";
  String errorAmount = "";
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage()),
      );
    }

    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 35, top: 25, right: 35, bottom: 10),
                      child: Container(
                        // color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                        height: 55,
                        child: TextField(
                          onChanged: (value) {
                            this._amount = value;
                            if (_amount != "") {
                              setState(() {
                                errorAmount = "";
                              });
                            }
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            counterText: "",
                            hintStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                fontSize: 14),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white70,
                                )),
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white70,
                            prefixIcon: Icon(Icons.monetization_on),
                            hintText: 'Enter Amount',
                          ),
                        ),
                      ),
                    ),
                    (errorAmount != ''
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              errorAmount,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : Container()),
                    _button(context)
                  ])),
        ),
      ),
    );
  }

  _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ButtonTheme(
        height: 40,
        minWidth: 290,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
              onPressed: () {
                if (_amount != "") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              amount: _amount,
                            )),
                  );
                } else {
                  setState(() {
                    errorAmount = "Please fill this field";
                  });
                  Toast.show("Please fill the field", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Pay Now',
                style: GoogleFonts.karla(
                    color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              elevation: 7,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
        ),
      ),
    );
  }
}
