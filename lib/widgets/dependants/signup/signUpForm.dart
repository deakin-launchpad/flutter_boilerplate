import 'package:flutter/material.dart';
import '../../../models/models.dart';
import '../../../helpers/API/api.dart';
import 'signUpTextfField.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();
  final SignUpValues signUpValues = SignUpValues();
  final lastname = FocusNode();
  final email = FocusNode();
  final password = FocusNode();
  final cpassword = FocusNode();
  final number = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpFormKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: <Widget>[
          SignupTextField(
            label: 'First Name',
            hint: 'John',
            action: TextInputAction.next,
            onSaved: (value) {
              signUpValues.firstname = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(lastname);
            },
            type: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the first name';
              }
              return null;
            },
          ),
          SignupTextField(
            focusNode: lastname,
            label: 'Last Name',
            hint: 'Doe',
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.lastname = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(email);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the last name';
              }
              return null;
            },
          ),
          SignupTextField(
            focusNode: email,
            label: 'Email',
            hint: 'johndoe@shaktiman.com',
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.lastname = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(password);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the email';
              }
              Pattern emailPattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(emailPattern as String);
              if (!regex.hasMatch(value)) return 'Enter Valid Email';
              return null;
            },
          ),
          SignupTextField(
            focusNode: password,
            label: 'Password',
            hint: 'secretpassword',
            isPassword: true,
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.password = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(cpassword);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the password';
              }
              return null;
            },
          ),
          SignupTextField(
            focusNode: cpassword,
            label: 'Confirm Password',
            hint: 'secretpassword',
            isPassword: true,
            action: TextInputAction.next,
            type: TextInputType.text,
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(number);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the confirmation password';
              }
              if (value != signUpValues.password) {
                return 'Passwords don\'t match';
              }
              return null;
            },
          ),
          SignupTextField(
            focusNode: number,
            label: 'Number',
            hint: '412345678',
            action: TextInputAction.done,
            type: TextInputType.number,
            onSaved: (value) {
              print(value);
              signUpValues.number = value;
            },
            onSubmit: (_) {},
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the number';
              }
              return null;
            },
          ),
          ElevatedButton(
            child: Text('SignUp'),
            onPressed: () async {
              print(signUpValues.number);
              var response = await API().registerUser({
                "firstName": signUpValues.firstname.toString(),
                "lastName": signUpValues.lastname.toString(),
                "emailId": signUpValues.email.toString(),
                "phoneNumber": signUpValues.number.toString(),
                "countryCode": "+61",
                "password": signUpValues.password
              });
              if (response) {
                ScaffoldMessenger(
                  child: Text('User Registered'),
                );
                return;
              } else {
                ScaffoldMessenger(
                  child: new Text('Registration Error!'),
                );
                return;
              }
            },
          ),
          ElevatedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
