import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String loadingText;
  LoadingScreen(this.loadingText);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'lib/assets/img/logo/logo.jpg',
              alignment: Alignment.center,
            ),
            Text(
              loadingText,
              style: TextStyle(fontSize: 30, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
