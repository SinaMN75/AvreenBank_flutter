import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/charge_history/charge_history_page.dart";
import "package:avreen_bank/view/pages/statements/statement_page.dart";
import "package:avreen_bank/view/pages/status_face/status_face_page.dart";
import "package:u/utilities.dart";

class AccountCard extends StatelessWidget {
  const AccountCard({required this.account, super.key});

  final AccountInfo account;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color color = account.getColor();
    final Color strong = Color.lerp(color, scheme.onSurface, 0.3)!;
    final bool isCredit = account.accountType == "CREDIT";
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          UContainer(
            radius: 20,
            color: color.withValues(alpha: 0.08),
            border: Border.all(color: color.withValues(alpha: 0.25)),
            padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 14,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    UContainer(
                      width: 42,
                      height: 42,
                      radius: 12,
                      alignment: Alignment.center,
                      color: scheme.surface,
                      child: Icon(account.getIcon(), color: color, size: 24),
                    ),
                    const SizedBox(width: 10),
                    UTextTitleMedium(
                      account.accountTypeName ?? "---",
                      color: strong,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      expanded: 1,
                    ),
                    const SizedBox(width: 8),
                    UTextTitleMedium(
                      (account.availableBalance ?? 0).separate3By3().toPersianNumber(),
                      color: strong,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 4),
                    UTextLabelMedium(U.s.rial, color: scheme.onSurfaceVariant),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: <Widget>[
                    _action(
                      scheme: scheme,
                      color: color,
                      title: U.s.turnover,
                      onTap: () => UNavigator.push(StatementPage(accountInfo: account)),
                    ),
                    _action(
                      scheme: scheme,
                      color: color,
                      title: U.s.chargeReport,
                      onTap: () => UNavigator.push(
                        ChargeHistoryPage(accountInfo: account, type: isCredit ? ChargeHistoryPageType.credit : ChargeHistoryPageType.account),
                      ),
                    ),
                    _action(
                      scheme: scheme,
                      color: color,
                      title: U.s.billingStatement,
                      isEnabled: isCredit,
                      onTap: () => UNavigator.push(StatusFacePage(accountInfo: account)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PositionedDirectional(start: 0, top: 0, bottom: 0, width: 5, child: ColoredBox(color: color)),
        ],
      ),
    );
  }

  Widget _action({
    required ColorScheme scheme,
    required Color color,
    required String title,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) => UContainer(
    expanded: 1,
    radius: 12,
    color: isEnabled ? scheme.surface : scheme.surface.withValues(alpha: 0.5),
    border: Border.all(color: color.withValues(alpha: 0.35)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
    onTap: isEnabled ? onTap : null,
    child: UTextBodySmall(
      title,
      color: color.withValues(alpha: isEnabled ? 1 : 0.2),
      fontWeight: FontWeight.w600,
      maxLines: 1,
      textAlign: TextAlign.center,
    ),
  );
}
