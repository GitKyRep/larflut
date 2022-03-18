import 'package:flutter/material.dart';

class CustomTextfieldContainer extends StatelessWidget {
  final Widget? child;

  const CustomTextfieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: child,
    );
  }
}
