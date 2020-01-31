import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final bool isFlat;
  final Color color;
  AdaptiveButton({@required this.child, @required this.onPressed, this.isFlat,this.color});
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoButton(
        child: child,
        onPressed: onPressed,
        color: color,
      );
    else
      return isFlat == true
          ? FlatButton(
              child: child,
              onPressed: onPressed,
              color: color,
            )
          : RaisedButton(
              child: child,
              onPressed: onPressed,
              color: color
            );
  }
}
