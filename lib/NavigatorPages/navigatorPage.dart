
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/fragments/live_chat.dart';
import 'package:kaamkhoj/fragments/partner_us.dart';
import 'package:kaamkhoj/fragments/payment.dart';
import 'package:kaamkhoj/fragments/rate_card.dart';
import 'package:kaamkhoj/fragments/services.dart';
import 'package:kaamkhoj/fragments/share_app.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fragments/first_fragment.dart';
import '../fragments/about_us.dart';
import '../fragments/how_we_work.dart';
import '../fragments/terms_employee.dart';
import '../fragments/terms_employer.dart';
import '../fragments/contact_us.dart';

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
    new DrawerItem("Want A Employee?", Icons.local_pizza),
    new DrawerItem("Want A Job?", Icons.local_pizza),
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

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
//        return new PasswordChangePage("Employer","+919594976005");
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
        return new ChooseYourWork("Employer");
      case 9:
        return new ChooseYourWork("Employee");          //ChooseType("register");//Sign UP
      case 10:
        return new ContactUsPage();
      case 11:
        return new ShareAppPage();
      case 12:
        return new PaymentPage();
      case 13:
        return new LiveChatPage();
      case 14:
//        return new LogoutPage();
        logout();
        return LoginPage();

      default:
        return new Text("Error",style: GoogleFonts.ptSans(),
        );
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

      if (i==7) {
        drawerOptions.add(
             Column(
               children: [
                 ListTile(
                  leading: new Icon(d.icon),
                  title: new Text(d.title),
                  selected: i == _selectedDrawerIndex,
                  onTap: () => _onSelectItem(i),
            ),
                 Divider(),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Padding(
                     padding: const EdgeInsets.only(left:20.0),
                     child: Text("Label",textAlign: TextAlign.left ,style:GoogleFonts.ptSans(
                         color: Colors.black,
                         fontSize: 20,
                         fontWeight: FontWeight.bold) ),
                   ),
                 ),
               ],
             )
        );
    }
      else if(i==9){
        drawerOptions.add(
            Column(
              children: [
                ListTile(
                  leading: new Icon(d.icon),
                  title: new Text(d.title),
                  selected: i == _selectedDrawerIndex,
                  onTap: () => _onSelectItem(i),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text("Label",textAlign: TextAlign.left ,style:GoogleFonts.ptSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold) ),
                  ),
                ),
              ],
            )
        );
      }
      else if(i==13){
        drawerOptions.add(
            Column(
              children: [
                ListTile(
                  leading: new Icon(d.icon),
                  title: new Text(d.title),
                  selected: i == _selectedDrawerIndex,
                  onTap: () => _onSelectItem(i),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text("Logout",textAlign: TextAlign.left ,style:GoogleFonts.ptSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold) ),
                  ),
                ),
              ],
            )
        );
      }
      else{
        drawerOptions.add(
            new ListTile(
              leading: new Icon(d.icon),
              title: new Text(d.title),
              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
            )
        );

      }
    }

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          // here we display the title corresponding to the fragment
          // you can instead choose to have a static title
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title,
          style: GoogleFonts.ptSans(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
        ),

        drawer: new Drawer(
          child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Container(
              height: 250,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset("assets/images/logo2.png",height: 200,width:MediaQuery.of(context).size.width),
                  ),
                  Center(child: Text('John Doe',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
               Column(children: drawerOptions),
            ],
          ),
        ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }

  Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Remove String
      prefs.remove("Login");
  }
}