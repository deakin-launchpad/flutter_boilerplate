import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class ChangePassword extends StatelessWidget {
  static final String route = '/changePassword';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 50,
          ),
          child: ChangePasswordForm(),
        ),
      ),
    );
  }
}
