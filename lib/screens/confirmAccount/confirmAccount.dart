import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/constants.dart';
import '../../models/models.dart';
import '../../helpers/helpers.dart';

class ConfirmAccount extends StatefulWidget {
  static const String route = '/confirm/:email/:password';

  final String? email, password;

  const ConfirmAccount({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _ConfirmAccountState createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(Constants.OTP_GIF_IMAGE),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Account Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xfff79c4f),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: widget.email,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Invalid code";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveColor: const Color(0xfff79c4f),
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "Invalid code" : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () => snackBar("OTP resend!!"),
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                              color: Color(0xfff79c4f),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        formKey.currentState!.validate();
                        logger.i("Test");
                        setState(() {
                          _loading = true;
                        });
                        DIOResponseBody confirmResponse = await AmplifyAuth()
                            .amplifyConfirmSignUp(widget.email!, currentText);

                        if (confirmResponse.success) {
                          LoginAPIBody userCreds = LoginAPIBody(
                              username: widget.email!,
                              password: widget.password!);

                          DIOResponseBody loginResponse =
                              await AmplifyAuth().amplifyUserLogin(userCreds);

                          if (loginResponse.success) {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.of(context).pushReplacementNamed('/home');
                          }

                          setState(() {
                            _loading = false;
                          });
                          // return snackBar(loginResponse.data);
                        }
                        // conditions for validating
                        if (currentText.length != 6 ||
                            !confirmResponse.success) {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                            _loading = false;
                          });
                        }
                      },
                      child: Center(
                        child: _loading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text(
                                "VERIFY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
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
                      colors: [Color(0xfffbb448), Color(0xfff7892b)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
