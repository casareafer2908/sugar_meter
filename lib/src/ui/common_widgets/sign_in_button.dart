import 'package:flutter/material.dart';
import 'package:sugar_meter/src/ui/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Key key,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          key: key,
          child: Text(text,
              style: TextStyle(
                color: textColor,
                fontSize: 15.0,
              )),
          color: color,
          borderRadius: 2.0,
          onPressed: onPressed,
        );
}
