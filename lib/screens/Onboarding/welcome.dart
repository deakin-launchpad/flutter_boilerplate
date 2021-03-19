import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_layout_builder/responsive_layout_builder.dart';
import 'package:user_onboarding/configurations/configurations.dart';
import '../../helpers/Layout/LayoutHelper.dart';

class WelcomePage extends StatefulWidget {
  static String route = '/welcome';
  WelcomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  LayoutHelper _layoutHelper = new LayoutHelper();

  double getButtonSize(context, LayoutSize currentSize) {
    switch (currentSize) {
      case LayoutSize.tablet:
        return MediaQuery.of(context).size.width / 4;
      case LayoutSize.desktop:
        return MediaQuery.of(context).size.width / 3;
      default:
        return MediaQuery.of(context).size.width;
    }
  }

  Widget _loginButton() {
    return ResponsiveLayoutBuilder(
      builder: (context, size) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Container(
            width: getButtonSize(context, size.size),
            padding: EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xffdf8e33).withAlpha(100),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 2)
                ],
                color: Colors.white),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _signUpButton() {
    return ResponsiveLayoutBuilder(builder: (context, size) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/signup');
        },
        child: Container(
          width: getButtonSize(context, size.size),
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            'Register now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    });
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'flutter',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'base',
              style: TextStyle(color: Colors.white70, fontSize: 30),
            ),
            TextSpan(
              text: 'plate',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _authorText() {
    double _fontSize = _layoutHelper.isTablet(context) ? 15 : 20;
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Developed',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: _fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
            ),
            children: [
              TextSpan(
                text: ' By ',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: _fontSize,
                ),
              ),
              TextSpan(
                text: Configurations().author,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _fontSize,
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buttons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loginButton(),
        SizedBox(
          height: 20,
        ),
        _signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.red,
                Colors.orange,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _buttons(),
              SizedBox(
                height: 20,
              ),
              if (!_layoutHelper.isWeb) _label(),
              _authorText(),
            ],
          ),
        ),
      ),
    );
  }
}
