part of upgrade_overlay;

/// Single upgrade slot: label, button, and formatted price.
class _UpgradeSlot<T> extends StatefulWidget {
  const _UpgradeSlot({
    required this.upgrade,
    required this.name,
    required this.cost,
  });

  final T upgrade;
  final String Function(T) name;
  final int Function(T) cost;

  static String _formatCost(int cost) =>
      '\$${cost.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';

  @override
  State<_UpgradeSlot<T>> createState() => _UpgradeSlotState<T>();
}

class _UpgradeSlotState<T> extends State<_UpgradeSlot<T>> {
  @override
  void initState() {
    super.initState();
    upgradesOg.addListener(_onStateUpdate);
    moneyOg.addListener(_onStateUpdate);
  }

  void _onStateUpdate(_) {
    setState(() {});
  }

  @override
  void dispose() {
    upgradesOg.removeListener(_onStateUpdate);
    moneyOg.removeListener(_onStateUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purchased = upgradesOg.state.hasPurchased(widget.upgrade);
    final cost = widget.cost(widget.upgrade);
    final canAfford = moneyOg.state.amount >= cost;
    final unlockedButCantAfford = !purchased && !canAfford;

    final labelColor = purchased
        ? Colors.white
        : (canAfford ? Colors.white : Colors.white54);
    final priceColor = purchased
        ? Colors.white70
        : (canAfford ? Colors.white70 : Colors.red.shade300);

    final slotContent = Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.name(widget.upgrade),
          style: TextStyle(color: labelColor, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Stack(
          children: [
            _UpgradeButton(
              isDisabled: purchased || !canAfford,
              width: 72,
              height: 28,
              onPressed: () {
                if (!purchased && canAfford) {
                  upgradesOg.events.purchase(widget.upgrade);
                }
              },
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Text(
                    _UpgradeSlot._formatCost(cost),
                    style: TextStyle(color: priceColor, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    if (unlockedButCantAfford) {
      final shortfall = cost - moneyOg.state.amount;
      return Tooltip(
        message:
            'Not enough money. Need ${_UpgradeSlot._formatCost(shortfall)} more.',
        child: slotContent,
      );
    }

    return slotContent;
  }
}
