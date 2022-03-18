import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final Color color, textColor;

  const CustomButton({
    Key? key,
    this.text,
    this.press,
    this.color = Colors.white,
    this.textColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width,
      child: ClipRRect(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            primary: color,
          ),
          onPressed: press as void Function()?,
          child: Text(
            text ?? "",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
