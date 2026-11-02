import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/karamat_receipt/karamat_receipt_page.dart";
import "package:avreen_bank/view/pages/karamat_transactions/karamat_transactions_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class KaramatTransactionsPage extends StatefulWidget {
  const KaramatTransactionsPage({required this.group, super.key});

  final GoodGroup group;

  @override
  State<KaramatTransactionsPage> createState() => _KaramatTransactionsPageState();
}

class _KaramatTransactionsPageState extends UState<KaramatTransactionsPage> {
  final KaramatTransactionsController c = KaramatTransactionsController();

  @override
  void initState() {
    c.init(group: widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PageHeader(title: widget.group.groupName ?? "طرح کرامت", subtitle: "تراکنش‌های طرح کرامت"),
        UObx(
          () {
            if (c.state.isLoading()) return const UProgressCircular().pOnly(top: 32).alignAtTopCenter();
            if (c.state.isError()) return UErrorRetry(onTap: () => c.init(group: widget.group)).pOnly(top: 32).alignAtTopCenter();
            return RefreshIndicator.adaptive(
              onRefresh: c.read,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  _summary(),
                  const SizedBox(height: 16),
                  if (c.state.isEmpty())
                    UEmptyState(title: U.s.noResults).pOnly(top: 24)
                  else
                    UColumn(
                      spacing: 14,
                      children: c.transactions.map(_transaction).toList(),
                    ),
                ],
              ),
            );
          },
        ).expanded(),
      ],
    ),
  );

  Widget _summary() => UContainer(
    radius: 20,
    color: AppColors.success.withValues(alpha: 0.08),
    border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 12,
      children: <Widget>[
        UIconBackground(Icons.inventory_2_outlined, color: AppColors.success, backgroundColor: scheme.surface),
        UTextBodyMedium("مانده", color: scheme.onSurfaceVariant, expanded: 1),
        UTextTitleMedium(widget.group.remWeight.gram(), fontWeight: FontWeight.bold),
        UTextLabelMedium("از ${widget.group.limitWeight.gram()}", color: scheme.onSurfaceVariant),
      ],
    ),
  );

  Widget _transaction(GoodGroupTransaction t) => UCard(
    color: scheme.surface,
    onTap: () {},
    child: ListTile(
      onTap: () => UNavigator.push(KaramatReceiptPage(group: widget.group, transaction: t)),
      leading: const UIconBackground(Icons.shopping_bag_outlined, color: AppColors.success),
      title: UTextBodyLarge(t.useWeight.gram(), color: AppColors.success),
      subtitle: UTextBodySmall("${t.oldWeight.gram()} ← ${t.newWeight.gram()}", color: scheme.onSurfaceVariant),
      trailing: UIconTextVertical(
        crossAxisAlignment: CrossAxisAlignment.end,
        leading: UTextLabelMedium(t.logDate.toJalaliDateTime(), color: scheme.onSurfaceVariant).ltr(),
        trailing: UTextLabelMedium("کش‌بک: ${t.cacheBack.rial()}", color: scheme.onSurfaceVariant),
      ),
    ),
  );
}
