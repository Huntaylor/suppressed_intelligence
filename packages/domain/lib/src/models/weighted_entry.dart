/// Weighted vocabulary entry. Higher weight = more likely to be selected.
/// Weight can also scale impact (e.g. WHO warning hits harder than Tech Giants).
class WeightedEntry<T> {
  const WeightedEntry(this.value, {this.weight = 1.0});

  final T value;
  final double weight;
}
