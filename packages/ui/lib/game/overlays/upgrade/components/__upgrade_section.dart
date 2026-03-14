part of upgrade_overlay;

class _UpgradeSection<T> extends StatelessWidget {
  const _UpgradeSection({
    required this.title,
    required this.firstUpgrade,
    required this.secondUpgrade,
    required this.thirdUpgrade,
    required this.fourthUpgrade,
    required this.fifthUpgrade,
    required this.name,
    required this.cost,
  });

  final String title;
  final String Function(T) name;
  final int Function(T) cost;
  final T firstUpgrade;
  final T secondUpgrade;
  final T thirdUpgrade;
  final T fourthUpgrade;
  final T fifthUpgrade;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 24)),
        _UpgradeSlot(upgrade: firstUpgrade, name: name, cost: cost),
        Row(
          spacing: 32,
          children: [
            Column(
              spacing: 16,
              children: <Widget>[
                _UpgradeSlot(upgrade: secondUpgrade, name: name, cost: cost),
                _UpgradeSlot(upgrade: fourthUpgrade, name: name, cost: cost),
              ],
            ),
            Column(
              spacing: 16,
              children: <Widget>[
                _UpgradeSlot(upgrade: thirdUpgrade, name: name, cost: cost),
                _UpgradeSlot(upgrade: fifthUpgrade, name: name, cost: cost),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
