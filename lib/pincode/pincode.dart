import 'dart:convert';

import 'package:http/http.dart';

Future<String> getCityName(String pincode) async {
  // make GET request
  String url = 'https://api.postalpincode.in/pincode/'+pincode;
  Response response = await get(url);
  // sample info available in response
//  int statusCode = response.statusCode;
//  Map<String, String> headers = response.headers;
//  String contentType = headers['content-type'];
//  String json = response.body;
  final jsonresponse = json.decode(response.body) as List;

//  Map<String, dynamic> user = jsonDecode(jsonresponse[0]);


  var postoffice=jsonresponse[0]['PostOffice'];

  if(jsonresponse[0]['Status']=="Error"){
    return "Not Exist";
  }

  for(int i=0;i<postoffice.length;i++){
    if(postoffice[i]['BranchType']=='Head Post Office'){
      return postoffice[i]['Name'];
    }
  }
  for(int i=0;i<postoffice.length;i++){
    if(postoffice[i]['BranchType']=='Sub Post Office' && postoffice[i]['DeliveryStatus']=='Delivery'){
      return postoffice[i]['Name'];
    }
  }

}