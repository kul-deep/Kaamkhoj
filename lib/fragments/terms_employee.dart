import 'package:flutter/material.dart';

class TermsEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[_buildTitle(),_column()]
        ),
      ),
      )
    ) ;
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('General Terms for Employee',style: TextStyle(color :Colors.red,fontSize: 25)),
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
        Text('• Before the selection by the employer it will be the sole responsibility of the employee to check the employers background, documents and references.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any misdeed committed by the employer or the employers family ,relation, friends, acquaintance etc in any manner whatsoever.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible in any manner whatsoever for any dispute that may arise between the employee and employer.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any loss, damage, misdeed committed by the employee will attract suitable legal action by the employer.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any advance payment or monetary transaction with employer will be at the employees risk.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Employees will be given two paid holidays per month. The employer & employee can decide when these holidays can to be taken.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in is not responsible to look into the matter of Employees like Annual Leave/Monthly Leave/Replacement of employee, Medical/Work Timings/ Type of job/ Salary/ increment of salary and any other miscellaneous issues. All these issues will be settled between the employer and the employee.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any negligence of the employer in any manner whatsoever.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),        
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• All the documents submitted by the employee to the employer are true to the best of the employees knowledge.'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employee applying for a job should be above the age of eighteen'),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any disputes that may arise will be settled in the courts at Mumbai.'),
            
      ]
    )
    );
  }
}
