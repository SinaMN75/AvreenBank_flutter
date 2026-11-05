import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/karamat/karamat_receipt/karamat_receipt_controller.dart";
import "package:u/utilities.dart";

class KaramatReceiptPage extends StatefulWidget {
  const KaramatReceiptPage({required this.transaction, super.key});

  final GoodGroupTransaction transaction;

  @override
  State<KaramatReceiptPage> createState() => _KaramatReceiptPageState();
}

class _KaramatReceiptPageState extends UState<KaramatReceiptPage> {
  final UWidgetToImageController controller = UWidgetToImageController();
  final KaramatReceiptController c = KaramatReceiptController();

  GoodGroupTransaction get t => widget.transaction;

  @override
  void initState() {
    c.init(transaction: widget.transaction);
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
        UWidgetToImage(controller: controller, child: _receipt()),
        _actions(),
      ],
    ),
  );

  Widget _receipt() => UContainer(
    color: scheme.surface,
    radius: 20,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
    child: UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: <Widget>[
        _header(),
        Divider(color: scheme.outlineVariant),
        _row(U.s.previousQuantity, t.oldWeight.gram()),
        _row(U.s.newQuantity, t.newWeight.gram()),
        _row(U.s.cashback, t.cacheBack.rial()),
        if (t.transactionId.isNotNullOrEmpty()) _row(U.s.transactionId, t.transactionId!),
        UObx(() {
          if (c.state.isLoading()) return const UProgressCircular().pSymmetric(vertical: 16);
          if (c.state.isError()) return UErrorRetry(onTap: c.read);
          return UColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: _detailRows(),
          );
        }),
      ],
    ),
  );

  Widget _header() => UColumn(
    mainAxisSize: MainAxisSize.min,
    spacing: 6,
    children: <Widget>[
      const UIconBackground(Icons.check_rounded, color: AppColors.success, size: 58),
      UTextHeadlineSmall(t.useWeight.gram(), color: AppColors.success),
      UTextLabelSmall(t.logDate?.formatJalaliDateTime() ?? "", color: scheme.onSurfaceVariant).ltr(),
    ],
  );

  List<Widget> _detailRows() {
    final TransactionDetailResponse? d = c.detail;
    return <Widget>[
      if (d?.merchantName.isNotNullOrEmpty() ?? false) _row(U.s.merchant, d!.merchantName!),
      if (d?.merchantAddress.isNotNullOrEmpty() ?? false) _row(U.s.address, d!.merchantAddress!),
      if (d?.stan.isNotNullOrEmpty() ?? false) _row(U.s.traceNumber, d!.stan!),
      if ((d?.discountAmount ?? 0) > 0) _row(U.s.discount, d!.discountAmount.rial()),
      if (d?.loanId.isNotNullOrEmpty() ?? false) _row(U.s.loanId, d!.loanId!),
      if (d?.loanId.isNotNullOrEmpty() ?? false) _row(U.s.loanId, d!.loanId!),
      if (d?.accountTypes.isNotEmpty ?? false) const Divider(),
      ...?d?.accountTypes.map((TransactionAccount e) => _row(e.accountTypeName ?? e.accountType ?? "", e.amount.rial())),
      if (d?.logMessage.isNotNullOrEmpty() ?? false) _row(U.s.description, d!.logMessage!),
    ];
  }

  Widget _row(String key, String value) => UKeyValue(
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

  Widget _actions() => UColumn(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    spacing: 8,
    children: <Widget>[
      UButton(title: U.s.share, icon: const Icon(Icons.share_outlined), onTap: _share, foregroundColor: scheme.onPrimary, fullWidth: true),
      Row(
        spacing: 8,
        children: <Widget>[
          UButton(title: U.s.saveItem(U.s.image), icon: const Icon(Icons.image_outlined), type: UButtonType.outlined, onTap: _save, expanded: 1),
          UButton(title: U.s.copy, icon: const Icon(Icons.copy_rounded), type: UButtonType.outlined, onTap: _copy, expanded: 1),
        ],
      ),
    ],
  );

  Future<void> _share() async {
    final UShareResult? result = await UShare.widgetImage(
      controller,
      name: "receipt_${t.transactionId ?? ""}.png",
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

  String _receiptText() {
    final TransactionDetailResponse? d = c.detail;
    return <String>[
      U.s.transactionReceipt,
      "${U.s.usedQuantity}: ${t.useWeight.gram()}",
      if (t.logDate.isNotNullOrEmpty()) "${U.s.date}: ${t.logDate.formatJalaliDateTime()}",
      "${U.s.previousQuantity}: ${t.oldWeight.gram()}",
      "${U.s.newQuantity}: ${t.newWeight.gram()}",
      "${U.s.cashback}: ${t.cacheBack.rial()}",
      if (t.transactionId.isNotNullOrEmpty()) "${U.s.transactionId}: ${t.transactionId}",
      if (d?.merchantName.isNotNullOrEmpty() ?? false) "${U.s.merchant}: ${d!.merchantName}",
      if (d?.merchantAddress.isNotNullOrEmpty() ?? false) "${U.s.address}: ${d!.merchantAddress}",
      if (d?.transactionType.isNotNullOrEmpty() ?? false) "${U.s.transactionType}: ${d!.transactionType}",
      if (d?.stan.isNotNullOrEmpty() ?? false) "${U.s.traceNumber}: ${d!.stan}",
      if (d?.docId.isNotNullOrEmpty() ?? false) "${U.s.documentNumber}: ${d!.docId}",
      if (d?.logMessage.isNotNullOrEmpty() ?? false) "${U.s.description}: ${d!.logMessage}",
    ].join("\n");
  }
}
