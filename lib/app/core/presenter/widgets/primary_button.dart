import 'package:flutter/material.dart';

import '../dimensions.dart';

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;
  final ButtonSize size;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.size = ButtonSize.large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: label,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          size == ButtonSize.expanded ? const Size(double.infinity, 44) : null,
        ),
        padding: MaterialStateProperty.all(
          size == ButtonSize.large
              ? const EdgeInsets.symmetric(horizontal: kLargeSpace, vertical: kLargeSpace * 0.75)
              : null,
        ),
        textStyle: MaterialStateProperty.all(
          size == ButtonSize.large ? Theme.of(context).textTheme.headline6 : null,
        ),
      ),
    );
  }
}

enum ButtonSize { large, expanded }
