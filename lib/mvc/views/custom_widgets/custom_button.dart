import 'package:flutter/material.dart';

import '../../../app_config.dart';


class CustomBtn extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CustomBtn({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: kPrimaryColor,
        child: Center(
          child: Text(
            title,style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
