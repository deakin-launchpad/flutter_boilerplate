import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class SignUp extends StatelessWidget {
  static String route = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.purple,
              Colors.red,
              Colors.orange,
            ])),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Flutter User Onboarding',
                  style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'pricedown',
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 15)
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                color: Colors.white,
                elevation: 50,
                child: SignUpForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
