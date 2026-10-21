import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/kalabarg/kalabarg_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class KalabargPage extends StatefulWidget {
  const KalabargPage({super.key});

  @override
  State<KalabargPage> createState() => _KalabargPageState();
}

class _KalabargPageState extends UState<KalabargPage> {
  final KalabargController c = KalabargController();

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
        PageHeader(title: U.s.kalabargBalance, subtitle: Core.currentFile.value.fileTitle),
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
                  _balance(),
                  const SizedBox(height: 14),
                  _familyCount(),
                ],
              ),
            );
          },
        ).expanded(),
      ],
    ),
  );

  Widget _balance() => UContainer(
    radius: 24,
    color: AppColors.voucher.withValues(alpha: 0.08),
    border: Border.all(color: AppColors.voucher.withValues(alpha: 0.25)),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
    child: UColumn(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UIconBackground(Icons.shopping_basket_outlined, color: AppColors.voucher, backgroundColor: scheme.surface, size: 56, radius: 16),
        UTextBodyMedium(U.s.kalabargBalance, color: scheme.onSurfaceVariant),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          spacing: 6,
          children: <Widget>[
            UTextHeadlineMedium((c.kalabarg?.balance ?? 0).separate3By3().toPersianNumber(), fontWeight: FontWeight.bold),
            UTextLabelMedium(U.s.rial, color: scheme.onSurfaceVariant),
          ],
        ),
      ],
    ),
  );

  Widget _familyCount() => UContainer(
    radius: 20,
    color: scheme.surface,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 12,
      children: <Widget>[
        UIconBackground(Icons.groups_outlined, color: scheme.primary),
        UTextBodyMedium(U.s.numberOfHouseholdMembers).expanded(),
        UTextTitleMedium((c.kalabarg?.familyCount ?? 0).toString().toPersianNumber(), fontWeight: FontWeight.bold),
      ],
    ),
  );
}
