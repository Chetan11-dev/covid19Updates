import 'package:flutter/material.dart';

class CircularSafeView extends StatelessWidget {
  final String title;
  final Widget child;
  const CircularSafeView({Key key, this.child, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}

class SafeView extends StatelessWidget {
  final Widget child;
  const SafeView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
