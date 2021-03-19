import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/widgets.dart';
import '../../configurations/configurations.dart';
import '../../helpers/helpers.dart';
import '../../providers/providers.dart';
import '../../models/models.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final double height;
  LoginForm({
    required this.formKey,
    required this.height,
  });
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _devModeSwitchValue = false;
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final UserLoginDetails loginValues = UserLoginDetails();
  final Configurations _config = new Configurations();

  Widget _textField(
    String title, {
    bool isPassword = false,
    String? hintText,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    void Function(String?)? onSaved,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: onSaved,
            keyboardType: keyboardType,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            obscureText: isPassword,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _loginButton(Function onPressed) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: new Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void changeDevModeValue(bool value) {
    setState(() {
      _devModeSwitchValue = value;
    });
  }

  Widget _emailPasswordWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _textField(
          "Email id",
          focusNode: _usernameFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          hintText: 'JohnDoe@example.com',
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) {
            loginValues.username = value;
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please Enter the Email';
            if (!TextHelper().validateEmail(value)) return 'Enter Valid Email';
            return null;
          },
        ),
        _textField(
          "Password",
          isPassword: true,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) {
            loginValues.username = value;
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please Enter the Email';
            if (!TextHelper().validateEmail(value)) return 'Enter Valid Email';
            return null;
          },
        ),
      ],
    );
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
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'base',
              style: TextStyle(color: Colors.black54, fontSize: 30),
            ),
            TextSpan(
              text: 'plate',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '  /signup');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Signup',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void performLogin(Function assignToken) async {
      if (widget.formKey.currentState!.validate()) {
        widget.formKey.currentState!.save();
        DIOResponseBody loginCheck;
        if (_devModeSwitchValue) {
          loginCheck = await API().userLogin(_config.getDevDetails);
        } else {
          loginCheck = await API().userLogin(loginValues);
        }
        if (loginCheck.success) {
          assignToken(loginCheck.data);
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(
              content: Text(loginCheck.data),
            ),
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: widget.height * .2),
        _title(),
        SizedBox(height: 50),
        _emailPasswordWidget(),
        SizedBox(height: 20),
        Consumer<UserDataProvider>(
          builder: (_, data, __) => _loginButton(
            () {
              if (_config.bypassBackend) {
                data.assignAccessToken(_config.devAccessToken);
                Navigator.of(context).pushReplacementNamed('/home');
                return;
              }
              performLogin(data.assignAccessToken);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerRight,
          child: Text('Forgot Password ?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        _divider(),
        SizedBox(height: widget.height * .055),
        _createAccountLabel(),
      ],
    );
  }
}

class Login extends StatelessWidget {
  final LayoutHelper _layoutHelper = new LayoutHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double getFormWidth(context) {
    if (MediaQuery.of(context).size.width > 1200) {
      return MediaQuery.of(context).size.width / 4;
    }
    if (MediaQuery.of(context).size.width > 786) {
      return MediaQuery.of(context).size.width / 3;
    }
    if (MediaQuery.of(context).size.width > 600) {
      return MediaQuery.of(context).size.width / 2;
    }
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    Widget _backButton() {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
              ),
              Text('Back',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (MediaQuery.of(context).size.width < 786)
              Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
            Container(
              width: getFormWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: LoginForm(
                  formKey: _formKey,
                  height: height,
                ),
              ),
            ),
            Positioned(top: 60, left: 10, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
