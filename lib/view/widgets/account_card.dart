import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/statements/statement_page.dart";
import "package:u/utilities.dart";

class AccountCard extends StatelessWidget {
  final AccountInfo account;

  const AccountCard({required this.account, super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = account.getColor();
    return UContainer(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      color: color.withValues(alpha: 0.04),
      radius: 16,
      child: URow(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: <Widget>[
          UIconBackground(account.getIcon(), color: color, backgroundColor: context.colorScheme.surface),
          const SizedBox(width: 12),
          UIconTextVertical(
            crossAxisAlignment: CrossAxisAlignment.start,
            leading: UTextBodyLarge((account.accountTypeName ?? "---").subStringIfExist(0, 24), color: color, fontWeight: FontWeight.bold, ),
            trailing: UContainer(
              width: 100,
              maxWidth: 100,
              flexible: 1,
              border: Border.all(color: color.withValues(alpha: 0.5)),
              color: context.colorScheme.surface,
              radius: 24,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: UTextBodyMedium(U.s.statement, color: color),
              onTap: () => UNavigator.push(TransactionsPage(accountInfo: account)),
            ),
          ),
          const Spacer(),
          UIconTextHorizontal(
            spaceBetween: 2,
            leading: UTextBodyLarge((account.availableBalance ?? 0).separate3By3(), color: color),
            trailing: UTextLabelSmall(U.s.rial),
          ),
        ],
      ),
    );
  }
}
