import 'dart:convert';

import 'package:http/http.dart';

Future<String> getCityName(String pincode) async {
  // make GET request
  String url = 'https://api.postalpincode.in/pincode/' + pincode;
  Response response = await get(url);

  final jsonresponse = json.decode(response.body) as List;

  var postoffice = jsonresponse[0]['PostOffice'];

  if (jsonresponse[0]['Status'] == "Error") {
    return "Please Enter a Valid Pincode+Please Enter a Valid Pincode";
  }

  String region;

  for (int i = 0; i < postoffice.length; i++) {
    if (postoffice[i]['BranchType'] == 'Head Post Office') {
      if (postoffice[i]['Block'] == "NA") {
        region = postoffice[i]['Region'];
      } else {
        region = postoffice[0]['Block'];
      }
      return postoffice[i]['Name'] + "+" + region;
    }
  }
  for (int i = 0; i < postoffice.length; i++) {
    if (postoffice[i]['BranchType'] == 'Sub Post Office' &&
        postoffice[i]['DeliveryStatus'] == 'Delivery') {
      if (postoffice[i]['Block'] == "NA") {
        region = postoffice[i]['Region'];
      } else {
        region = postoffice[0]['Block'];
      }
      return postoffice[i]['Name'] + "+" + region;
    }
  }

  if (postoffice[0]['Block'] == "NA") {
    region = postoffice[0]['Region'];
  } else {
    region = postoffice[0]['Block'];
  }
  return postoffice[0]['Name'] + "+" + region;
}
