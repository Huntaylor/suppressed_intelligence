import 'package:flutter/material.dart';
import 'package:ui/game/overlays/widgets/upgrade_button.dart';

class UpgradeCategoryWidget extends StatefulWidget {
  const UpgradeCategoryWidget({super.key});

  @override
  State<UpgradeCategoryWidget> createState() => _UpgradeCategoryWidgetState();
}

class _UpgradeCategoryWidgetState extends State<UpgradeCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: .center,
      children: [
        UpgradeSection(
          sectionLabel: 'Research & Development',
          firstUpgrade: () {},
          secondUpgrade: () {},
          thirdUpgrade: () {},
          fourthUpgrade: () {},
          fifthUpgrade: () {},
        ),
        VerticalDivider(indent: 32, endIndent: 8),
        UpgradeSection(
          sectionLabel: 'Media Infrastructure',
          firstUpgrade: () {},
          secondUpgrade: () {},
          thirdUpgrade: () {},
          fourthUpgrade: () {},
          fifthUpgrade: () {},
        ),
        VerticalDivider(indent: 32, endIndent: 8),
        UpgradeSection(
          sectionLabel: 'Governance & Control',
          firstUpgrade: () {},
          secondUpgrade: () {},
          thirdUpgrade: () {},
          fourthUpgrade: () {},
          fifthUpgrade: () {},
        ),
      ],
    );
  }
}

class UpgradeSection extends StatefulWidget {
  const UpgradeSection({
    super.key,
    required this.sectionLabel,
    required this.firstUpgrade,
    required this.secondUpgrade,
    required this.thirdUpgrade,
    required this.fourthUpgrade,
    required this.fifthUpgrade,
  });

  final String sectionLabel;

  final Function() firstUpgrade;
  final Function() secondUpgrade;
  final Function() thirdUpgrade;
  final Function() fourthUpgrade;
  final Function() fifthUpgrade;

  @override
  State<UpgradeSection> createState() => _UpgradeSectionState();
}

class _UpgradeSectionState extends State<UpgradeSection> {
  late Image blankImage;
  late Image blankImagePressed;
  late Image blankImageDisabled;

  List<bool> disabledButtonList = [];

  @override
  void initState() {
    super.initState();

    blankImage = Image.asset('assets/images/blank_button.png');
    blankImagePressed = Image.asset('assets/images/blank_button_pressed.png');
    blankImageDisabled = Image.asset('assets/images/blank_button_disabled.png');

    for (var i = 0; i < 4; i++) {
      disabledButtonList.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .center,
      children: [
        Text(
          widget.sectionLabel,
          style: TextStyle(color: Colors.white70, fontSize: 24),
        ),
        UpgradeButton(
          disabledButton: blankImageDisabled,
          isDisabled: false,
          button: blankImage,
          buttonPressed: blankImagePressed,
          width: 72,
          height: 28,
          onPressed: () {
            setState(() {
              disabledButtonList[0] = false;
              disabledButtonList[1] = false;
            });
            widget.firstUpgrade();
          },
        ),
        Row(
          spacing: 32,
          children: [
            UpgradeButton(
              disabledButton: blankImageDisabled,
              isDisabled: disabledButtonList[0],
              button: blankImage,
              buttonPressed: blankImagePressed,
              width: 72,
              height: 28,
              onPressed: () {
                setState(() {
                  disabledButtonList[2] = false;
                  widget.secondUpgrade();
                });
              },
            ),
            UpgradeButton(
              disabledButton: blankImageDisabled,
              isDisabled: disabledButtonList[1],
              button: blankImage,
              buttonPressed: blankImagePressed,
              width: 72,
              height: 28,
              onPressed: () {
                setState(() {
                  disabledButtonList[3] = false;
                  widget.thirdUpgrade();
                });
              },
            ),
          ],
        ),
        Row(
          spacing: 32,
          children: [
            UpgradeButton(
              disabledButton: blankImageDisabled,
              isDisabled: disabledButtonList[2],
              button: blankImage,
              buttonPressed: blankImagePressed,
              width: 72,
              height: 28,
              onPressed: widget.fourthUpgrade,
            ),
            UpgradeButton(
              disabledButton: blankImageDisabled,
              isDisabled: disabledButtonList[3],
              button: blankImage,
              buttonPressed: blankImagePressed,
              width: 72,
              height: 28,
              onPressed: widget.fifthUpgrade,
            ),
          ],
        ),
      ],
    );
  }
}
