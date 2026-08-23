import "package:avreen_bank/model/account_model.dart";
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
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: ULetterBadge(account.badge, background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
            title: UIconTextVertical(
              spaceBetween: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              leading: UTextBodyMedium(account.title, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: UTextLabelSmall(account.number.toPersianNumber(), color: scheme.onSurfaceVariant, textDirection: TextDirection.ltr),
            ),
            trailing: UTextTitleMedium(balanceHidden ? "••••••" : account.balance.rial(), fontWeight: FontWeight.bold),
          ),
          if (account.chips.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Row(
              spacing: 6,
              children: account.chips.map((String chip) => UTextLabelSmall(chip).chip(backgroundColor: scheme.primary.withValues(alpha: 0.1))).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
