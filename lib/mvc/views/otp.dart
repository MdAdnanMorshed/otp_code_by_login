

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:test_task_otp/app_config.dart';

import 'custom_widgets/custom_button.dart';

class OTP extends StatefulWidget {
  final String code;
  final String phone;

  const OTP({Key key, this.code,this.phone}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {


  bool _buttonDisabled = true;
  String _verificationCode = '';

  int _flashSaleSecond = 33;
  bool isResend = false;
  Timer _flashsaleTimer;

  @override
  void initState() {
    _startOTPTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:
        Stack(children: [
            Positioned(
            left: 40,
            top: 40,
            child: InkWell(
                onTap: () {
                  ///todo list press
                  Get.back();
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                  size: 30,
                ))

        ),
        ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset('assets/images/verify.PNG'),
            Center(
                child: Text('Verification Code',style: TextStyle(fontSize: 30,color: kPrimaryColor),

                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Center(
                child: Text(
                  'Please type the code we sent to \n ' +widget.phone,style: TextStyle(color: Colors.grey),

                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: PinCodeTextField(
                autoFocus: true,
                appContext: context,
                keyboardType: TextInputType.number,
                length: 5,
                showCursor: false,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: kSuccessColor,
                    activeColor: kPrimaryColor,
                    selectedColor: kGreyColor
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                onChanged: (value) {
                  setState(() {
                    if(value.length==5){
                      _buttonDisabled = false;
                    } else {
                      _buttonDisabled = true;
                    }
                    _verificationCode = value;
                  });
                },
                beforeTextPaste: (text) {
                  return false;
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Wrap(
                children: [
                  Text(
                      'Code Sent Try again in '
                  ),
                  _buildOTPTimer(),
                 /* GestureDetector(
                    onTap: (){
                      _startOTPTimer();
                      print('verify code resend  click');
                    },
                    child: Text(
                      'resend',

                    ),
                  )*/
                ],
              ),
            ),
            CustomBtn(
              title: 'Next',
              onPressed: () {
                //Get.to(OTP());
                /*  if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Map<String, String> body = {
                            'phone': _authPhone,
                            'password': _authPassword
                          };

                          ApiProvider().logInUser(body).then(
                                (value) {
                              if (value != null) {
                                SPFLocalSave()
                                    .saveUserInformationInSharedPref(value)
                                    .then((isValue) {
                                  if (isValue) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              BottomNavigationBarPage()),
                                          (Route<dynamic> route) => false,
                                    );
                                  }
                                });

                                // Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Login is wrong! please try again ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                print('_LoginScreenState._loginUser : ' +
                                    'login failed');
                              }
                            },
                          );
                        }*/
              },
            ),
            SizedBox(
              height: 40,
            ),

          ],
        )
    ]),);
  }

  void _startOTPTimer() {
    const period = const Duration(seconds: 1);
    _flashsaleTimer = Timer.periodic(period, (timer) {
      setState(() {
        _flashSaleSecond--;
      });
      if (_flashSaleSecond == 0) {
        _cancelOTPTimer();
        Get.snackbar('Alert','OTP Time is Over ' );
      }
    });
  }

  void _cancelOTPTimer() {
    if (_flashsaleTimer != null) {
      _flashsaleTimer.cancel();
      _flashsaleTimer = null;
    }
  }

  Widget _buildOTPTimer() {
    int second = _flashSaleSecond % 60;
    if (second == 0) {
      setState(() {
        isResend = true;
      });
      return GestureDetector(
        onTap: () {

        },
        child: Text(
          'Resend',
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    } else {
      return Text('  ' + formatTime(second) + ' Seconds',
          style: TextStyle(
              color: Colors.red, fontSize: 14, fontWeight: FontWeight.normal));
    }
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }
}



