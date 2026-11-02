import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/karamat/karamat_controller.dart";
import "package:avreen_bank/view/pages/karamat_transactions/karamat_transactions_page.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class KaramatPage extends StatefulWidget {
  const KaramatPage({super.key});

  @override
  State<KaramatPage> createState() => _KaramatPageState();
}

class _KaramatPageState extends UState<KaramatPage> {
  final KaramatController c = KaramatController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PageHeader(title: "طرح کرامت", subtitle: Core.currentFile.value.fileTitle),
        UObx(
          () {
            if (c.state.isLoading()) return const UProgressCircular().pOnly(top: 32).alignAtTopCenter();
            if (c.state.isError()) return UErrorRetry(onTap: c.init).pOnly(top: 32).alignAtTopCenter();
            return RefreshIndicator.adaptive(
              onRefresh: c.read,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  if (c.state.isEmpty())
                    UEmptyState(title: U.s.noResults).pOnly(top: 24)
                  else
                    UColumn(
                      spacing: 14,
                      children: c.groups.map(_group).toList(),
                    ),
                ],
              ),
            );
          },
        ).expanded(),
      ],
    ),
  );

  Widget _group(GoodGroup g) => UContainer(
    radius: 20,
    color: scheme.surface,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.all(16),
    onTap: () => UNavigator.push(KaramatTransactionsPage(group: g)),
    child: UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 14,
      children: <Widget>[
        Row(
          spacing: 12,
          children: <Widget>[
            const UIconBackground(Icons.inventory_2_outlined, color: AppColors.success),
            UColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              expanded: 1,
              children: <Widget>[
                UTextTitleMedium(g.groupName ?? "", fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                if (g.regDate.isNotNullOrEmpty()) UTextLabelSmall(g.regDate.toJalaliDateTime(), color: scheme.onSurfaceVariant).ltr(),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).disabledColor, size: 16),
          ],
        ),
        UProgressLinear(
          value: g.remainingPercent(),
          progressColor: AppColors.success,
          backgroundColor: AppColors.success.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        Row(
          children: <Widget>[
            UTextBodySmall("مانده: ${g.remWeight.gram()}", color: scheme.onSurface, fontWeight: FontWeight.w600, expanded: 1),
            UTextBodySmall("سقف: ${g.limitWeight.gram()}", color: scheme.onSurfaceVariant),
          ],
        ),
      ],
    ),
  );
}
