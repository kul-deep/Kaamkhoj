import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/afterlogin/employee_form.dart';
import 'package:kaamkhoj/fragments/choose_work.dart';
import 'package:kaamkhoj/fragments/live_chat.dart';
import 'package:kaamkhoj/fragments/logout.dart';
import 'package:kaamkhoj/fragments/partner_us.dart';
import 'package:kaamkhoj/fragments/payment.dart';
import 'package:kaamkhoj/fragments/rate_card.dart';
import 'package:kaamkhoj/fragments/services.dart';
import 'package:kaamkhoj/fragments/share_app.dart';
import 'package:kaamkhoj/loginresgiter/choosetype.dart';

import '../fragments/first_fragment.dart';
import '../fragments/about_us.dart';
import '../fragments/how_we_work.dart';
import '../fragments/terms_employee.dart';
import '../fragments/terms_employer.dart';
import '../fragments/contact_us.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class NavigatorPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.rss_feed),
    new DrawerItem("About Us", Icons.local_pizza),
    new DrawerItem("How We Work", Icons.info),
    new DrawerItem("Services", Icons.info),
    new DrawerItem("Terms For Employee", Icons.info),
    new DrawerItem("Terms For Employer", Icons.info),
    new DrawerItem("Rate Card", Icons.local_pizza),
    new DrawerItem("Partner Us", Icons.local_pizza),
    new DrawerItem("Login", Icons.local_pizza),
    new DrawerItem("Sign Up", Icons.local_pizza),
    new DrawerItem("Contact Us", Icons.local_pizza),
    new DrawerItem("Please Share This App", Icons.local_pizza),
    new DrawerItem("Online Payment", Icons.local_pizza),
    new DrawerItem("Live Chat", Icons.local_pizza),
    new DrawerItem("Logout", Icons.local_pizza),
  ];

  @override
  State<StatefulWidget> createState() {
    return new NavigatorPageState();
  }
}

class NavigatorPageState extends State<NavigatorPage> {
  // void _showBottom(){
  //   showModalBottomSheet<void>(
  //       context: context,
  //       /*bottom sheet is like a drawer that pops off where you can put any
  //     controls you want, it is used typically for user notifications*/
  //       //builder lets your code generate the code
  //       builder: (BuildContext context){
  //         return new Container(
  //           padding: new EdgeInsets.all(15.0),
  //           child: new Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               new Text('Some info here', style: new TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
  //               new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('Close'),)
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeFragment();
      case 1:
        return new AboutUsPage();
      case 2:
        return new HowWeWorkPage();
      case 3:
        return new ServicesPage();
      case 4:
        return new TermsEmployeePage();
      case 5:
        return new TermsEmployerPage();
      case 6:
        return new RateCard();
      case 7:
        return new PartnerUsPage();
      case 8:
        return new ChooseType("login");//Login
      case 9:
        return new ChooseType("register");//Sign UP
      case 10:
        return new ContactUsPage();
      case 11:
        return new ShareAppPage();
      case 12:
        return new PaymentPage();
      case 13:
        return new LiveChatPage();
      case 14:
        return new LogoutPage();

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),

      drawer: new Drawer(
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
             Column(children: drawerOptions),
          ],
        ),
      ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}