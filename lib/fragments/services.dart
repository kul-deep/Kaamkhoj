 import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';

 class ServicesPage extends StatelessWidget {
   var font1 = GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold);
   @override
   Widget build(BuildContext context) {
     // TODO: implement build
     return Scaffold(       
       body: Container(
         width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage("assets/images/background.png"),
      fit: BoxFit.cover
            )
          ),
          //  color: Colors.white,
           padding: EdgeInsets.only(left:10,top:40.0),
           child: SingleChildScrollView(
                        child: Table(
//           border: TableBorder.all(color: Colors.black),
               children: [
                 TableRow(children: [
                   Text('•   Babysitter',style: font1),
                   Text('•   Cook',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Domestic Helper',style: font1),
                   Text('•   Housemaid',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Home Tutions',style: font1),
                   Text('•   Japa Maid',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Patient Care',style: font1),
                   Text('•   Office Boy',style: font1),               ]),
                 TableRow(children: [
                   Text('•   Carpenter',style: font1),
                   Text('•   Computer Operator',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Couple',style: font1),
                   Text('•   Data Entry Operator',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Delivery Boy',style: font1),
                   Text('•   Driver',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Electrician',style: font1),
                   Text('•   Helper',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   House Boy',style: font1),
                   Text('•   House Supervisor',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Mason',style: font1),
                   Text('•   Nurse',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Office Assistant',style: font1),
                   Text('•   Painter',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Peon',style: font1),
                   Text('•   Plumber',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Salesman',style: font1),
                   Text('•   Security Guard',style: font1),
                 ]),
                 TableRow(children: [
                   Text('•   Nanny',style: font1),
                   Text(''),
                 ]),

               ],
             ),
           ),
         )

     );
   }

 }