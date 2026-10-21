import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/fara_balance/fara_balance_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class FaraBalancePage extends StatefulWidget {
  const FaraBalancePage({super.key});

  @override
  State<FaraBalancePage> createState() => _FaraBalancePageState();
}

class _FaraBalancePageState extends UState<FaraBalancePage> {
  final FaraBalanceController c = FaraBalanceController();

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
        PageHeader(title: "موجودی کالابرگ", subtitle: Core.currentFile.value.fileTitle),
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
                  if (c.faraBalance?.balance != null)
                    _balance()
                  else
                    _error(),
                  const SizedBox(height: 14),
                  _familyCount(),
                  const SizedBox(height: 14),
                  _nationalCode(),
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
    color: AppColors.success.withValues(alpha: 0.08),
    border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
    child: UColumn(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UIconBackground(Icons.shopping_basket_outlined, color: AppColors.success, backgroundColor: scheme.surface, size: 56, radius: 16),
        UTextBodyMedium("موجودی کالابرگ", color: scheme.onSurfaceVariant),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          spacing: 6,
          children: <Widget>[
            UTextHeadlineMedium((c.faraBalance?.balance ?? 0).separate3By3(), fontWeight: FontWeight.bold),
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
        const UTextBodyMedium("تعداد اعضای خانوار", expanded: 1),
        UTextTitleMedium((c.faraBalance?.familyCount ?? 0).toString(), fontWeight: FontWeight.bold),
      ],
    ),
  );

  Widget _error() => UContainer(
    radius: 20,
    color: AppColors.danger.withValues(alpha: 0.1),
    border: Border.all(color: AppColors.danger),
    padding: const EdgeInsets.all(16),
    child: ListTile(
      leading: const UIconBackground(Icons.error, color: AppColors.danger),
      title: UTextTitleMedium(c.faraBalance?.alertMessage ?? U.s.unexpectedErrorPleaseTryAgain, fontWeight: FontWeight.bold, maxLines: 1),
    ),
  );

  Widget _nationalCode() => UContainer(
    radius: 20,
    color: scheme.surface,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 12,
      children: <Widget>[
        UIconBackground(Icons.groups_outlined, color: scheme.primary),
        const UTextBodyMedium("شناسه کالابرگ", expanded: 1),
        UTextTitleMedium((c.faraBalance?.nationalCode ?? 0).toString(), fontWeight: FontWeight.bold).ltr(),
      ],
    ),
  );
}
