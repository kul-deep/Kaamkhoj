library pin_entry_text_field;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PinEntryTextField extends StatefulWidget {
  final String lastPin;
  final int fields;
  final ValueChanged<String> onSubmit;
  final num fieldWidth;
  final num fontSize;
  final bool isTextObscure;
  final bool showFieldAsBox;

  PinEntryTextField(
      {this.lastPin,
      this.fields: 6,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  int _counter = 30;
  Color c = Colors.grey[700];
  Timer _timer;

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          setState(() {
            c = Color.fromARGB(0xff, 0x88, 0x02, 0x0b);
          });
        }
      });
    });
  }

  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context, i == 0);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context, [bool autofocus = false]) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autofocus: autofocus,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.black,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            border: widget.showFieldAsBox
                ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return textfields;
    return Scaffold(
        backgroundColor: Color(0xfff7e9e9),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'Enter OTP',
                style: GoogleFonts.ptSans(
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              textfields,
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '00:$_counter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: new GestureDetector(
                        onTap: () {

                        },
                        child: new Text(
                          'Resend OTP',
                          style: GoogleFonts.ptSans(
                              color: c,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                  height: 40,
                  minWidth: 290,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            c = Colors.grey[700];
                          });
                          _startTimer();

                          // sformKey.currentState.();
                          // verifyPhone();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'verify',
                          style: GoogleFonts.karla(
                              color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        elevation: 7,
                        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                  )),
            ],
          ),
        ));
  }
}
