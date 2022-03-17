import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: label,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(
          double.infinity,
          44,
        )),
      ),
    );
  }
}
