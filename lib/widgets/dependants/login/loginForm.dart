import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/constants.dart';
import '../../../helpers/helpers.dart';
import '../../../providers/providers.dart';
import '../../../models/models.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final double height;
  const LoginForm({
    required this.formKey,
    required this.height,
  });
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _devModeSwitchValue = false;

  bool _loading = false;
  bool isPassword = false;

  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final LoginAPIBody loginValues = LoginAPIBody();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _textField(
    String title, {
    String? hintText,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    void Function(String?)? onSaved,
    TextEditingController? controller,
    bool isPasswordForm = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            cursorColor: Colors.black,
            onSaved: onSaved,
            controller: controller,
            keyboardType: keyboardType,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            obscureText: isPasswordForm ? !isPassword : false,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                fillColor: const Color(0xfff3f3f4),
                filled: true,
                suffixIcon: isPasswordForm
                    ? IconButton(
                        icon: Icon(
                          isPassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      )
                    : null),
          )
        ],
      ),
    );
  }

  Widget _loginButton(void Function()? onPressed) {
    return GestureDetector(
      onTap: _loading ? null : onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: _loading
            ? const CircularProgressIndicator.adaptive()
            : const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  void changeDevModeValue(bool value) {
    setState(() {
      _devModeSwitchValue = value;
    });
  }

  Widget _userCredentialsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _textField(
          "Username or Email",
          focusNode: _usernameFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          keyboardType: TextInputType.text,
          isPasswordForm: false,
          //isPassword: false,
          onSaved: (value) {
            loginValues.username = value;
          },
          controller: _usernameController,
          validator: (value) {
            if (value!.isEmpty) return 'Please enter the username';
            return null;
          },
        ),
        _textField(
          "Password",
          //isPassword: true,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          onSaved: (value) {
            loginValues.password = value;
          },
          isPasswordForm: true,
          controller: _passwordController,
          validator: (value) {
            if (value!.isEmpty) return 'Please enter the password';
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
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: const [
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
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
        Navigator.pushNamed(context, '/signup');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
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

  void _regularLogin(DIOResponseBody response, Function assignToken) async {
    if (response.success) {
      await assignToken(response.data['accessToken']);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data),
        ),
      );
    }
  }

  void _amplifyLogin(DIOResponseBody response) async {
    if (response.success && response.data) {
      setState(() {
        _loading = false;
      });

      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        _loading = false;
      });

      if (response.data == AMPLIFY_EXCEPTION.UserNotConfirmedException) {
        Navigator.pushReplacementNamed(context,
            '/confirm/${loginValues.username}/${loginValues.password}');
      } else {
        final String errMessage = response.data.underlyingException != null
            ? response.data.underlyingException
                .toString()
                .split(':')[1]
                .split('.')[0]
                .trim()
            : response.data.message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errMessage),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void performLogin(
        Function assignToken, Function changeFirstLoginStatus) async {
      if (widget.formKey.currentState == null) {
        debugPrint('emptyformkey');
      } else if (widget.formKey.currentState!.validate()) {
        widget.formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        DIOResponseBody response;

        if (Constants.amplifyEnabled) {
          if (_devModeSwitchValue) {
            response = await AmplifyAuth.amplifyUserLogin(Constants.devUser);
          } else {
            response = await AmplifyAuth.amplifyUserLogin(loginValues);
          }
          _amplifyLogin(response);
        } else {
          if (_devModeSwitchValue) {
            response = await API().userLogin(Constants.devUser);
          } else {
            response = await API().userLogin(loginValues);
          }
          _regularLogin(response, assignToken);
        }
      }
    }

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: widget.height * .2),
          _title(),
          const SizedBox(height: 50),
          _userCredentialsWidget(),
          const SizedBox(height: 20),
          Consumer<UserDataProvider>(
            builder: (_, data, __) => _loginButton(
              () {
                if (Constants.bypassBackend) {
                  data.assignAccessToken(Constants.devAccessToken);
                  Navigator.of(context).pushReplacementNamed('/home');
                  return;
                }
                performLogin(
                    data.assignAccessToken, data.changeFirstLoginStatus);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: const Text('Forgot Password ?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          _divider(),
          SizedBox(height: widget.height * .055),
          _createAccountLabel(),
        ],
      ),
    );
  }
}
