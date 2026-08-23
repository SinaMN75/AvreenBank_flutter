import "package:avreen_bank/model/account_model.dart";
import "package:avreen_bank/utils/money_extension.dart";
import "package:avreen_bank/view/widgets/info_chip.dart";
import "package:avreen_bank/view/widgets/letter_badge.dart";
import "package:u/utilities.dart";

class AccountCard extends StatelessWidget {
  const AccountCard(this.account, {required this.balanceHidden, super.key});

  final AccountModel account;
  final bool balanceHidden;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return UContainer(
      color: scheme.surface,
      radius: 18,
      border: Border.all(color: scheme.outlineVariant),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LetterBadge(account.badge, background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UTextBodyMedium(account.title, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 3),
                    UTextLabelSmall(account.number.toPersianNumber(), color: scheme.onSurfaceVariant, textDirection: TextDirection.ltr),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  UTextTitleMedium(balanceHidden ? "••••••" : account.balance.money, fontWeight: FontWeight.bold),
                  const SizedBox(height: 2),
                  UTextLabelSmall(U.s.toman, color: scheme.onSurfaceVariant),
                ],
              ),
            ],
          ),
          if (account.chips.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: account.chips.map((String chip) => InfoChip(chip)).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
