part of upgrade_overlay;

class _UpgradeButton extends StatefulWidget {
  const _UpgradeButton({
    required this.width,
    required this.height,
    required this.onPressed,
    required this.isDisabled,
  });

  final VoidCallback onPressed;
  final bool isDisabled;
  final double width;
  final double height;

  @override
  State<_UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<_UpgradeButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final state = _State(isPressed: isPressed, isDisabled: widget.isDisabled);

    return GestureDetector(
      onTapDown: switch (state) {
        _State(isDisabled: true) => null,
        _ => (details) {
          setState(() {
            musicOg.events.playSfx(SfxType.upgrade);
            isPressed = true;
          });
        },
      },
      onTapUp: switch (state) {
        _State(isDisabled: true) => null,
        _ => (details) {
          widget.onPressed();
          setState(() => isPressed = false);
        },
      },
      child: MouseRegion(
        cursor: switch (state) {
          _State(isDisabled: true) => SystemMouseCursors.basic,
          _ => SystemMouseCursors.click,
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: switch (state) {
            _State(isDisabled: true) => Image.asset(
              'assets/images/blank_button_disabled.png',
            ),
            _State(isPressed: true) => Image.asset(
              'assets/images/blank_button_pressed.png',
            ),
            _ => Image.asset('assets/images/blank_button.png'),
          },
        ),
      ),
    );
  }
}

class _State {
  _State({required this.isPressed, required this.isDisabled});

  final bool isPressed;
  final bool isDisabled;
}
