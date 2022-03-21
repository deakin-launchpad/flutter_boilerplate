import 'package:flutter/material.dart';

class SignupTextField extends StatelessWidget {
  final String? label, hint;
  final TextInputType? type;
  final TextInputAction? action;
  final void Function(String)? onSubmit;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isPassword;
  const SignupTextField({
    this.hint,
    this.label,
    this.action,
    this.onSubmit,
    this.onSaved,
    this.type,
    this.validator,
    this.focusNode,
    this.controller,
    this.isPassword,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: onSaved,
        keyboardType: type,
        focusNode: focusNode,
        controller: controller,
        onFieldSubmitted: onSubmit,
        validator: validator,
        obscureText: isPassword == null ? false : isPassword!,
        textInputAction: action,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          fillColor: const Color(0xfff3f3f4),
          filled: true,
        ),
      ),
    );
  }
}
