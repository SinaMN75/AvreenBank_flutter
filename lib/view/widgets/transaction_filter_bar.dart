import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:u/utilities.dart";

class TransactionFilterBar extends StatelessWidget {
  const TransactionFilterBar({required this.selected, required this.onChanged, super.key});

  final TransactionFilter selected;
  final ValueChanged<TransactionFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Map<TransactionFilter, String> labels = <TransactionFilter, String>{
      TransactionFilter.all: U.s.all,
      TransactionFilter.credit: U.s.credit,
      TransactionFilter.debit: U.s.debit,
    };
    return UChipChoice<TransactionFilter>(
      options: labels.keys.toList(),
      selected: selected,
      spacing: 6,
      onChanged: (int index, bool isSelected, TransactionFilter item) => onChanged(item),
      chipBuilder: (TransactionFilter item, bool isSelected, int index) => UContainer(
        color: isSelected ? scheme.primary : scheme.surface,
        radius: 9,
        border: Border.all(color: isSelected ? scheme.primary : scheme.outlineVariant),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: UTextLabelSmall(labels[item]!, color: isSelected ? scheme.onPrimary : scheme.onSurfaceVariant),
      ),
    );
  }
}
