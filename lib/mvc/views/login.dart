
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:test_task_otp/mvc/controllers/login_controller.dart';
import 'package:test_task_otp/mvc/views/otp.dart';

import '../../app_config.dart';
import 'custom_widgets/custom_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isHidTap = true;
  final TextEditingController controller = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());
  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 40,
            top: 40,
            child: InkWell(
                onTap: () {
                   ///todo list press
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30,
                ))

            ),
        Center(
          child: Container(
            child: SingleChildScrollView(

              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: _formKey,
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Test Task',style: TextStyle(fontSize: 50,color: kPrimaryColor),),
                    SizedBox(height: 50.0),
                    Text('Phone Number'),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: true,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: false,
                      keyboardType:
                      TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(value: true),
                          Text(
                            'You agree to our ',
                          ),
                          SizedBox(width: 7.0),
                          GestureDetector(
                            onTap: () {
                              ///todo press
                            },
                            child: Text(
                              'Terms & Conditions',style:  TextStyle(color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    CustomBtn(
                      title: 'Continue',
                      onPressed: () {
                      /* if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();*/
                          Map<String, String> body = {
                            'phone': '01831679008',};
                          String  code =_loginController.verifyCodeByPhone('');
                          print('callback : '+code.toString());
                         /* if(code==''){
                            Get.snackbar('Alert', "server issue");
                          }else{*/
                            Get.offAll(OTP(code: code,phone: '01831679008',));
                          //}

                     //   }
                      },
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            'Don\'t have an account?',
                          ),
                          SizedBox(width: 7.0),
                          GestureDetector(
                            onTap: () {
                              ///todo press
                            },
                            child: Text(
                              'Sign In',
                              style:  TextStyle(color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'BD');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();

}
}

