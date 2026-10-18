import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/receipt/receipt_controller.dart";
import "package:u/utilities.dart";

class ReceiptPage extends StatefulWidget {
  const ReceiptPage(this.info, {super.key});

  final TransactionInfo info;

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends UState<ReceiptPage> {
  final UWidgetToImageController controller = UWidgetToImageController();
  final ReceiptController c = ReceiptController();

  TransactionInfo get info => widget.info;

  @override
  void initState() {
    c.init(info: widget.info);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    appBar: AppBar(title: Text(U.s.transactionReceipt)),
    body: UColumn(
      scrollable: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      spacing: 16,
      children: <Widget>[
        UWidgetToImage(controller: controller, child: _receipt(scheme)),
        _actions(scheme),
      ],
    ),
  );

  Widget _receipt(ColorScheme scheme) => UContainer(
    color: scheme.surface,
    radius: 20,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
    child: UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: <Widget>[
        _header(scheme),
        Divider(color: scheme.outlineVariant),
        UObx(() {
          if (c.state.isLoading()) return const UProgressCircular().pSymmetric(vertical: 16);
          if (c.state.isError()) return UErrorRetry(onTap: c.read);
          return UColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: _rows(scheme),
          );
        }),
      ],
    ),
  );

  Widget _header(ColorScheme scheme) => UColumn(
    mainAxisSize: MainAxisSize.min,
    spacing: 6,
    children: <Widget>[
      UIconBackground(info.isSuccessful() ? Icons.check_rounded : Icons.close_rounded, color: info.color(), size: 58),
      UTextTitleMedium(info.statusName(), color: info.color()),
      UTextHeadlineSmall(info.transactionAmount.rial(), color: info.isSuccessful() ? AppColors.success : scheme.onSurface),
      UTextLabelSmall(info.logDate?.formatJalaliDateTime() ?? "", color: scheme.onSurfaceVariant).ltr(),
    ],
  );

  List<Widget> _rows(ColorScheme scheme) {
    final TransactionDetailResponse? d = c.detail;
    return <Widget>[
      if (d?.merchantName.isNotNullOrEmpty() ?? false) _row(scheme, U.s.merchant, d!.merchantName!),
      if (d?.merchantAddress.isNotNullOrEmpty() ?? false) _row(scheme, U.s.address, d!.merchantAddress!),
      _row(scheme, U.s.terminalType, info.terminalTypeName()),
      if (d?.transactionType.isNotNullOrEmpty() ?? false) _row(scheme, U.s.transactionType, info.debitTypeName()),
      if (info.rrn.isNotNullOrEmpty()) _row(scheme, U.s.referenceNumber, info.rrn!),
      if (d?.stan.isNotNullOrEmpty() ?? false) _row(scheme, U.s.traceNumber, d!.stan!),
      if ((d?.discountAmount ?? 0) > 0) _row(scheme, U.s.discount, d!.discountAmount.rial()),
      if (d?.loanId.isNotNullOrEmpty() ?? false) _row(scheme, U.s.loanId, d!.loanId!),
      const Divider(),
      ...?d?.accountTypes.map((TransactionAccount e) => _row(scheme, e.accountTypeName ?? e.accountType ?? "", e.amount.rial())),
      if (d?.logMessage.isNotNullOrEmpty() ?? false) _row(scheme, U.s.description, d!.logMessage!),
    ];
  }

  Widget _row(ColorScheme scheme, String key, String value) => UKeyValue(
    leading: UTextBodySmall(key, color: scheme.onSurfaceVariant),
    trailing: UTextBodyMedium(
      value,
      fontWeight: FontWeight.w600,
      textAlign: TextAlign.end,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      expanded: 1,
    ),
    crossAxisAlignment: CrossAxisAlignment.start,
  );

  Widget _actions(ColorScheme scheme) => UColumn(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    spacing: 8,
    children: <Widget>[
      UButton(title: U.s.share, icon: const Icon(Icons.share_outlined), onTap: _share, foregroundColor: scheme.onPrimary, fullWidth: true),
      Row(
        spacing: 8,
        children: <Widget>[
          UButton(title: U.s.saveImage, icon: const Icon(Icons.image_outlined), type: UButtonType.outlined, onTap: _save, expanded: 1),
          UButton(title: U.s.copy, icon: const Icon(Icons.copy_rounded), type: UButtonType.outlined, onTap: _copy, expanded: 1),
        ],
      ),
    ],
  );

  Future<void> _share() async {
    final UShareResult? result = await UShare.widgetImage(
      controller,
      name: "receipt_${c.detail?.stan ?? info.rrn ?? ""}.png",
      text: _receiptText(),
    );
    if (result == null) UToast.errorToast(message: U.s.somethingWentWrong);
  }

  Future<void> _save() async {
    final Uint8List? bytes = await controller.capture();
    if (bytes == null) {
      UToast.errorToast(message: U.s.somethingWentWrong);
      return;
    }
    final File file = await UFile.writeToFile(bytes, extension: "png");
    UToast.successToast(message: "${U.s.screenshotSaved}\n${file.path}");
  }

  void _copy() => UClipboard.set(_receiptText(), snackBar: true);

  String _receiptText() =>
      c.detail?.receiptText(info) ??
      <String>[
        U.s.transactionReceipt,
        "${U.s.amount}: ${info.transactionAmount.rial()}",
        if (info.logDate.isNotNullOrEmpty()) "${U.s.date}: ${info.logDate.formatJalaliDateTime()}",
        "${U.s.status}: ${info.statusName()}",
      ].join("\n");
}
