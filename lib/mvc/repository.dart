import 'dart:convert';

import 'package:http/http.dart' as https;

class Repository{
  Future <String> getVerifyCode(String phoneNumber) async {
    String url ='https://mocki.io/v1/9a3d57b9-fa3f-402e-99f9-982134108d18';
    var response = await https.get(url);
    print('response check :'+response.statusCode.toString());
    print('response body :'+response.body.toString());
    if (response.statusCode == 200) {

      var jsonMap = jsonDecode(response.body);
      var code = jsonMap['otp_code'];
      print('cod:'+code.toString());
      return code;
    } else {
      print( 'API call failed with status code ${response.statusCode}');
      return null;
    }
  }
}