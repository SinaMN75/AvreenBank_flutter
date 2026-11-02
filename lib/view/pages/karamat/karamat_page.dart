import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/karamat/karamat_controller.dart";
import "package:avreen_bank/view/pages/karamat/karamat_transactions/karamat_transactions_page.dart";
import "package:avreen_bank/view/widgets/good_group_icon.dart";
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
        PageHeader(
          title: "طرح کرامت",
          subtitle: Core.currentFile.value.fileTitle,
          trailingWidget: UButton(
            title: U.s.more,
            onTap: () => UNavigator.push(
              UScaffold(
                appBar: AppBar(),
                body: const UWebView(initialUrl: "https://pwa.tj724.ir/keramat/index.html"),
              ),
            ),
          ),
        ),
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
                    UGridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      maxCrossAxisExtent: 220,
                      childAspectRatio: 1.05,
                      itemCount: c.groups.length,
                      itemBuilder: (BuildContext context, int index) => _group(c.groups[index]),
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
    padding: const EdgeInsets.all(14),
    onTap: () => UNavigator.push(KaramatTransactionsPage(group: g)),
    child: UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GoodGroupIcon(groupId: g.groupId),
            UCircularPercentIndicator(
              center: UTextLabelMedium("${g.remainingPercent()}%", color: AppColors.success, fontWeight: FontWeight.bold),
              progressColor: AppColors.success,
              backgroundColor: AppColors.success.withValues(alpha: 0.12),
              radius: 20,
              lineWidth: 2,
              percent: (g.remainingPercent().toDouble() / 100),
            ),
          ],
        ),
        UTextTitleSmall(g.groupName ?? "", fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
        UColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: <Widget>[
            UTextBodyMedium("مانده: ${g.remWeight.gram()}", fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
            UTextLabelSmall("سقف: ${g.limitWeight.gram()}", color: scheme.onSurfaceVariant, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ],
    ),
  );
}
