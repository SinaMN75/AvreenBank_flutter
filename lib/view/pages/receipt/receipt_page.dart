import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class ReceiptPage extends StatefulWidget {
  const ReceiptPage(this.info, {super.key});

  final TransactionInfo info;

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final WidgetToImageController controller = WidgetToImageController();

  TransactionInfo get info => widget.info;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return UScaffold(
      appBar: AppBar(title: Text(U.s.transactionReceipt)),
      body: UColumn(
        scrollable: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: const EdgeInsets.all(16),
        spacing: 16,
        children: <Widget>[
          WidgetToImage(controller: controller, child: _receipt(scheme)),
          _actions(scheme),
        ],
      ),
    );
  }

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
        ..._rows(scheme),
        Divider(color: scheme.outlineVariant),
        UTextLabelSmall(
          "${Core.fileInfo.value.firstName ?? ""} ${Core.fileInfo.value.lastName ?? ""}",
          color: scheme.onSurfaceVariant,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _header(ColorScheme scheme) {
    final Color color = info.isSuccessful() ? AppColors.success : scheme.error;
    return UColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: <Widget>[
        UIconBackground(info.isSuccessful() ? Icons.check_rounded : Icons.close_rounded, color: color, size: 58),
        UTextTitleMedium(info.statusName(), color: color),
        UTextHeadlineSmall(info.transactionAmount.rial(), color: info.isCredit() ? AppColors.success : scheme.onSurface),
        UTextLabelSmall(info.logDate?.formatJalaliDateTime() ?? "", color: scheme.onSurfaceVariant),
      ],
    );
  }

  List<Widget> _rows(ColorScheme scheme) {
    final String? pan = info.pan();
    return <Widget>[
      if (info.merchantName.isNotNullOrEmpty()) _row(scheme, U.s.merchant, info.merchantName!),
      if (info.merchantAddress.isNotNullOrEmpty()) _row(scheme, U.s.address, info.merchantAddress!),
      if (pan.isNotNullOrEmpty()) _row(scheme, U.s.cardNumber, pan!.separateCharacters(4, " ")),
      _row(scheme, U.s.terminalType, info.terminalTypeName()),
      if (info.transactionType.isNotNullOrEmpty()) _row(scheme, U.s.transactionType, info.transactionType!),
      if (info.rrn.isNotNullOrEmpty()) _row(scheme, U.s.referenceNumber, info.rrn!),
      if (info.stan.isNotNullOrEmpty()) _row(scheme, U.s.traceNumber, info.stan!),
      if (info.docId.isNotNullOrEmpty()) _row(scheme, U.s.documentNumber, info.docId!),
      if (info.logMessage.isNotNullOrEmpty()) _row(scheme, U.s.description, info.logMessage!),
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
    final ShareResult? result = await UShare.widgetImage(
      controller: controller,
      fileName: "receipt_${info.stan ?? info.rrn ?? ""}.png",
      text: info.receiptText(),
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

  void _copy() => UClipboard.set(info.receiptText(), snackBar: true);
}
