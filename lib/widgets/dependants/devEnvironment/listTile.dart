import 'package:flutter/material.dart';

class DevEnvironmentListTile extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const DevEnvironmentListTile({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: TextButton(
        child: const Text('Test'),
        onPressed: onPressed,
      ),
    );
  }
}
