import 'package:flutter/material.dart';

class UpgradeButton extends StatefulWidget {
  const UpgradeButton({
    super.key,
    required this.button,
    required this.buttonPressed,
    required this.buttonLabel,
    required this.width,
    required this.height,
  });

  final Image button;
  final Image buttonPressed;
  final String buttonLabel;

  final double width;
  final double height;

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .center,
      children: [
        Text(
          widget.buttonLabel,
          style: TextStyle(color: Colors.white70, fontSize: 24),
        ),
        GestureDetector(
          onTapDown: (details) {
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              isPressed = false;
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: isPressed ? widget.buttonPressed : widget.button,
            ),
          ),
        ),
      ],
    );
  }
}
