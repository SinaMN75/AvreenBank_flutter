import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/statements/statement_page.dart";
import "package:u/utilities.dart";

class AccountCard extends StatelessWidget {
  const AccountCard({required this.account, required this.index, required this.balanceHidden, super.key});

  final AccountInfo account;
  final bool balanceHidden;
  final int index;

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
            leading: ULetterBadge((index + 1).toString(), background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
            title: UIconTextVertical(
              spaceBetween: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              leading: UTextBodyMedium(account.accountTypeName ?? "---", fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: UTextLabelSmall(account.debitExpireDate ?? "---", color: scheme.onSurfaceVariant, textDirection: TextDirection.ltr),
            ),
            trailing: UTextTitleMedium(balanceHidden ? "••••••" : account.availableBalance.rial(), fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              UButton(
                title: U.s.statement,
                type: UButtonType.text,
                icon: const Icon(Icons.show_chart, color: AppColors.brand),
                onTap: () => UNavigator.push(TransactionsPage(accountInfo: account)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
