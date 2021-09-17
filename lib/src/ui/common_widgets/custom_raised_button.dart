import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key key,
    this.child,
    this.color,
    this.borderRadius = 2.0,
    this.onPressed,
    this.height = 50.0,
  })  : assert(borderRadius != null),
        super(key: key); //constructor

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          shadowColor: Colors.grey,
        ),
      ),
    );
  }
}
