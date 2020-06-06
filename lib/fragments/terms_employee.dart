import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
class TermsEmployeePage extends StatelessWidget {
  var font1 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
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
          )
        ),
      ),
    ) ;
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('General Terms for Employee',style: GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
    ),);
  }
  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Before the selection by the employer it will be the sole responsibility of the employee to check the employers background, documents and references.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any misdeed committed by the employer or the employers family ,relation, friends, acquaintance etc in any manner whatsoever.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible in any manner whatsoever for any dispute that may arise between the employee and employer.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any loss, damage, misdeed committed by the employee will attract suitable legal action by the employer.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any advance payment or monetary transaction with employer will be at the employees risk.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Employees will be given two paid holidays per month. The employer & employee can decide when these holidays can to be taken.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in is not responsible to look into the matter of Employees like Annual Leave/Monthly Leave/Replacement of employee, Medical/Work Timings/ Type of job/ Salary/ increment of salary and any other miscellaneous issues. All these issues will be settled between the employer and the employee.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any negligence of the employer in any manner whatsoever.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),        
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• All the documents submitted by the employee to the employer are true to the best of the employees knowledge.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employee applying for a job should be above the age of eighteen',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any disputes that may arise will be settled in the courts at Mumbai.',textAlign: TextAlign.justify,style: font1,),
            
      ]
    )
    );
  }
}
