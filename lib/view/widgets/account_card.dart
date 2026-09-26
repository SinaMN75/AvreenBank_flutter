import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/statements/statement_page.dart";
import "package:u/utilities.dart";

class AccountCard extends StatelessWidget {
  const AccountCard({required this.account, super.key});

  final AccountInfo account;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color color = account.getColor();
    final Color strong = Color.lerp(color, scheme.onSurface, 0.3)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          UContainer(
            radius: 20,
            color: color.withValues(alpha: 0.08),
            border: Border.all(color: color.withValues(alpha: 0.25)),
            padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 14, 16),
            child: Row(
              children: <Widget>[
                UContainer(
                  width: 48,
                  height: 48,
                  radius: 16,
                  alignment: Alignment.center,
                  color: scheme.surface,
                  child: Icon(account.getIcon(), color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: <Widget>[
                      UTextTitleMedium(account.accountTypeName ?? "---", color: strong, fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                      UContainer(
                        radius: 20,
                        color: scheme.surface,
                        border: Border.all(color: color.withValues(alpha: 0.35)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        onTap: () => UNavigator.push(TransactionsPage(accountInfo: account)),
                        child: UTextBodySmall("${U.s.view} ${U.s.statement}", color: color, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                UTextTitleMedium((account.availableBalance ?? 0).separate3By3().toPersianNumber(), color: strong, fontWeight: FontWeight.bold),
                const SizedBox(width: 4),
                UTextLabelMedium(U.s.rial, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          PositionedDirectional(start: 0, top: 0, bottom: 0, width: 5, child: ColoredBox(color: color)),
        ],
      ),
    );
  }
}
