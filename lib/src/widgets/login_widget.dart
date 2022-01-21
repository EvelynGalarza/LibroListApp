import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.person, size: 50.0),
        Text("Login", style: Theme.of(context).textTheme.headline4)
      ],
    ));
  }
}
