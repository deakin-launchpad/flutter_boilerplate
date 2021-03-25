import 'package:flutter/material.dart';

class SignupTextField extends StatelessWidget {
  final String? label, hint;
  final TextInputType? type;
  final TextInputAction? action;
  final Function? validator, onSaved, onSubmit;
  final FocusNode? focusNode;
  final bool? isPassword;
  SignupTextField({
    this.hint,
    this.label,
    this.action,
    this.onSubmit,
    this.onSaved,
    this.type,
    this.validator,
    this.focusNode,
    this.isPassword,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: action,
        onFieldSubmitted: onSubmit as void Function(String)?,
        obscureText: isPassword == null ? false : isPassword!,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        keyboardType: type,
        onSaved: onSaved as void Function(String?)?,
        validator: validator as String? Function(String?)?,
      ),
    );
  }
}
