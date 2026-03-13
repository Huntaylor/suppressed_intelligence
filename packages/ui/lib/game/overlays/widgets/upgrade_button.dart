import 'package:flutter/material.dart';

class UpgradeButton extends StatefulWidget {
  const UpgradeButton({
    super.key,
    required this.button,
    required this.buttonPressed,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.isDisabled,
    required this.disabledButton,
  });

  final Image button;
  final Image buttonPressed;
  final Image disabledButton;

  final Function() onPressed;

  final bool isDisabled;

  final double width;
  final double height;

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  bool isPressed = false;

  Image get buttonSprite => widget.isDisabled
      ? widget.disabledButton
      : isPressed
      ? widget.buttonPressed
      : widget.button;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isDisabled
          ? null
          : (details) {
              widget.onPressed();
              setState(() {
                isPressed = true;
              });
            },
      onTapUp: widget.isDisabled
          ? null
          : (details) {
              setState(() {
                isPressed = false;
              });
            },
      child: MouseRegion(
        cursor: widget.isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: buttonSprite,
        ),
      ),
    );
  }
}
