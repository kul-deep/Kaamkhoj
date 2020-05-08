import 'package:flutter/material.dart';

import 'Login.dart';
import 'Register.dart';

class ChooseType extends StatelessWidget {
  String type;

  ChooseType(String type) {
    this.type = type;
    print(type);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (context) => RaisedButton(
                onPressed: () {
                  if (type == "login") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage("Employee")),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage("Employee")),
                    );
                  }
                },
                child: Text('Employee'),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.blue,
              ),
            ),
            Builder(
              builder: (context) => RaisedButton(
                onPressed: () {
                  if (type == "login") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage("Employer")),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage("Employer")),
                    );
                  }
                },
                child: Text('Employer'),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.blue,
              ),
            ),
          ]),
    )));
  }
}
