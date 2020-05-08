 import 'package:flutter/material.dart';

 class ServicesPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     // TODO: implement build
     return Scaffold(
       backgroundColor: Colors.white,
       body: Container(
           color: Colors.white,
           padding: EdgeInsets.all(20.0),
           child: Table(
//           border: TableBorder.all(color: Colors.black),
             children: [
               TableRow(children: [
                 Text('•   Babysitter'),
                 Text('•   Cook'),
               ]),
               TableRow(children: [
                 Text('•   Domestic Helper'),
                 Text('•   Housemaid'),
               ]),
               TableRow(children: [
                 Text('•   Home Tutions'),
                 Text('•   Japa Maid'),
               ]),
               TableRow(children: [
                 Text('•   Patient Care'),
                 Text('•   Office Boy'),               ]),
               TableRow(children: [
                 Text('•   Carpenter'),
                 Text('•   Computer Operator'),
               ]),
               TableRow(children: [
                 Text('•   Couple'),
                 Text('•   Data Entry Operator'),
               ]),
               TableRow(children: [
                 Text('•   Delivery Boy'),
                 Text('•   Driver'),
               ]),
               TableRow(children: [
                 Text('•   Electrician'),
                 Text('•   Helper'),
               ]),
               TableRow(children: [
                 Text('•   House Boy'),
                 Text('•   House Supervisor'),
               ]),
               TableRow(children: [
                 Text('•   Mason'),
                 Text('•   Nurse'),
               ]),
               TableRow(children: [
                 Text('•   Office Assistant'),
                 Text('•   Painter'),
               ]),
               TableRow(children: [
                 Text('•   Peon'),
                 Text('•   Plumber'),
               ]),
               TableRow(children: [
                 Text('•   Salesman'),
                 Text('•   Security Guard'),
               ]),
               TableRow(children: [
                 Text('•   Nanny'),
                 Text(''),
               ]),

             ],
           ),
         )

     );
   }

 }