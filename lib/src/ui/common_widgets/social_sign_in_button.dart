import 'package:flutter/material.dart';
import 'package:sugar_meter/src/ui/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    Key key,
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color,
          borderRadius: 2.0,
          onPressed: onPressed,
        );
}
