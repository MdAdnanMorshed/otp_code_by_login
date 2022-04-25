import 'package:get/get.dart';

import '../repository.dart';

class LoginController extends GetxController {

  var isResAPI = false.obs;
  String code='';
  String verifyCodeByPhone(phone) {
    Repository().getVerifyCode(phone).then((code) {
      print('otp code : '+code.toString());
      isResAPI.value = true;
       return code=code;
    }).catchError((error) {
      _errorMessageAlert(errorMsg: error);
    });
    return code;
  }
  /// Custom Error Message
  _errorMessageAlert({String errorMsg}) {
    Get.back();
    Get.snackbar(
      'Server Error :',
      errorMsg.toString(),
    );
  }
}