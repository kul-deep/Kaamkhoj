import 'package:flutter/material.dart';
import 'package:kaamkhoj/test/employee_form1.dart';
import 'package:kaamkhoj/test/employer_form.dart';

class ChooseYourWork extends StatefulWidget {
  String type,phoneNo;

  ChooseYourWork(String type,String phoneNo){
    this.type=type;
    this.phoneNo=phoneNo;
    print("Choose Your Work"+phoneNo);
  }
//  ChooseYourWork() : super();




  @override
  ChooseYourWorkState createState() => ChooseYourWorkState(type,phoneNo);
  
}

class User {
  int userId;
  String firstName;
  

  User({this.userId, this.firstName});

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "Babysitter/बेबीसिटर"),
      User(userId: 2, firstName: "Cook/रसोइया"),
      User(userId: 3, firstName: "Domestic Helper/घरेलू सहायक"),
      User(userId: 4, firstName: "Housemaid/नौकरानी"),
      User(userId: 5, firstName: "Home Tutions/घर ट्यूशन"),
      User(userId: 6, firstName: "Japa Maid/जापा नौकरानी"),
      User(userId: 7, firstName: "Nanny/दाई "),
      User(userId: 8, firstName: "Patient Care/रोगी की देखभाल "),
      User(userId: 9, firstName: "Office Boy/पीअन"),
      User(userId: 10, firstName: "Carpenter/बढ़ई"),
      User(userId: 11, firstName: "Computer Operator/कंप्यूटर ऑपरेटर"),
      User(userId: 12, firstName: "Couple/युगल"),
      User(userId: 13, firstName: "Data Entry Operator/तथ्य दाखिला प्रचालक"),
      User(userId: 14, firstName: "Delivery Boy/वितरण लड़का"),
      User(userId: 15, firstName: "Driver/चालक"),
      User(userId: 16, firstName: "Electrician/बिजली मिस्त्री"),
      User(userId: 17, firstName: "Helper/सहायक"),
      User(userId: 18, firstName: "House Boy/घर लड़का"),
      User(userId: 19, firstName: "House Supervisor/घर पर्यवेक्षक"),
      User(userId: 20, firstName: "Mason/मकान बनाने वाला"),
      User(userId: 21, firstName: "Nurse/नर्स"),
      User(userId: 22, firstName: "Office Assistant/कार्यालय सहायक"),
      User(userId: 23, firstName: "Painter/पेंटर"),
      User(userId: 24, firstName: "Peon/चपरासी"),
      User(userId: 25, firstName: "Plumber/नलसाज"),
      User(userId: 26, firstName: "Salesman/विक्रेता"),
      User(userId: 27, firstName: "Security Guard/सुरक्षा कर्मी"),
      
    ];
  }
}
 Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10),
    child: Text('Do you need any job? \nSelect of one of the box',style: TextStyle(color :Colors.red,fontSize: 25)),
    );
  }

class ChooseYourWorkState extends State<ChooseYourWork> {
  //
  List<User> users;
  User selectedUser;
  int selectedRadio;
  int selectedRadioTile;

  String type,phoneNo;
  ChooseYourWorkState(String type,String phoneNo){
    this.type=type;
    this.phoneNo=phoneNo;

  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getUsers();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (User user in users) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: selectedUser,
          title: Text(user.firstName),
          onChanged: (currentUser) {
            print("Current User ${currentUser.firstName}");
            setSelectedUser(currentUser);
          },
          selected: selectedUser == user,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_buildTitle(),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("USERS"),
                      ),
          Column(
            children: createRadioListUsers(),
                      ),
          
        ],
      ),
    ),
    bottomNavigationBar: Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: <Widget>[
          // Container(
          //   width: 66,
          //   color: Colors.green,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[Icon(Icons.chat, color: Colors.white), Text("CHAT", style: TextStyle(color: Colors.white))],
          //   ),
          // ),
          // Container(
          //   width: 66,
          //   color: Colors.green,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[Icon(Icons.notifications_active, color: Colors.white), Text("NOTIF", style: TextStyle(color: Colors.white))],
          //   ),
          // ),
          Expanded(
            child: GestureDetector(
        onTap: (){
//          print(selectedUser.firstName);
        if(type=="Employer") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployerForm(selectedUser.firstName,phoneNo)),
          );
        }
        else{
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => EmployeeForm(selectedUser.firstName,phoneNo)),
          );
          }


        },
              child: Container(
              
              alignment: Alignment.center,
              color: Colors.blue[300],
              child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18)),
            
            ),
          )),]
    )));
  }
}



//class RadioButtonWidget extends State {
//
//  String radioItem = '';
//
//  Widget build(BuildContext context) {
//    return Column(
//        children: <Widget>[
//
//          RadioListTile(
//              groupValue: radioItem,
//              title: Text('Radio Button Item 1'),
//              value: 'Item 1',
//              onChanged: (val) {
//                setState(() {
//                  radioItem = val;
//                });
//              },
//            ),
//
//           RadioListTile(
//              groupValue: radioItem,
//              title: Text('Radio Button Item 2'),
//              value: 'Item 2',
//              onChanged: (val) {
//                setState(() {
//                  radioItem = val;
//                });
//              },
//            ),
//
//           Text('$radioItem', style: TextStyle(fontSize: 23),)
//
//        ],
//    );
//  }
//}
