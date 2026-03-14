part of upgrade_overlay;

class _UpgradeSection<T> extends StatefulWidget {
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
  State<_UpgradeSection<T>> createState() => _UpgradeSectionState<T>();
}

class _UpgradeSectionState<T> extends State<_UpgradeSection<T>> {
  @override
  void initState() {
    super.initState();
    upgradesOg.addListener(_onStateUpdate);
  }

  void _onStateUpdate(_) {
    setState(() {});
  }

  @override
  void dispose() {
    upgradesOg.removeListener(_onStateUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(color: Colors.white70, fontSize: 24),
        ),
        _UpgradeSlot(
          upgrade: widget.firstUpgrade,
          canUpgrade: true,
          name: widget.name,
          cost: widget.cost,
        ),
        Row(
          spacing: 32,
          children: [
            Column(
              spacing: 16,
              children: <Widget>[
                _UpgradeSlot(
                  upgrade: widget.secondUpgrade,
                  canUpgrade: upgradesOg.state.hasPurchased(
                    widget.firstUpgrade,
                  ),
                  name: widget.name,
                  cost: widget.cost,
                ),
                _UpgradeSlot(
                  upgrade: widget.fourthUpgrade,
                  canUpgrade: upgradesOg.state.hasPurchased(
                    widget.secondUpgrade,
                  ),
                  name: widget.name,
                  cost: widget.cost,
                ),
              ],
            ),
            Column(
              spacing: 16,
              children: <Widget>[
                _UpgradeSlot(
                  upgrade: widget.thirdUpgrade,
                  canUpgrade: upgradesOg.state.hasPurchased(
                    widget.firstUpgrade,
                  ),
                  name: widget.name,
                  cost: widget.cost,
                ),
                _UpgradeSlot(
                  upgrade: widget.fifthUpgrade,
                  canUpgrade: upgradesOg.state.hasPurchased(
                    widget.thirdUpgrade,
                  ),
                  name: widget.name,
                  cost: widget.cost,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
