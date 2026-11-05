import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

// Phone acts as a contactless card (UNfcCard / Android HCE): while this page is open, the POS can read [valueToSend].
class NfcPage extends StatefulWidget {
  const NfcPage({required this.valueToSend, super.key});

  final String valueToSend;

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends UState<NfcPage> {
  // AvreenBank AID ("F0" + "AVREEN" + "01"); the POS (Apos CardController) SELECTs it to read the track2.
  static const String _aid = "F041565245454E01";

  bool ready = false;
  bool sent = false;
  String status = U.s.preparingNfc;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    UNfcCard.stop();
    super.dispose();
  }

  Future<void> _start() async {
    final UNfcStatus nfc = await UNfc.status();
    if (!nfc.cardEmulation) return _setStatus(U.s.thisPhoneDoesNotSupportNfcPayment);
    if (!nfc.isEnabled) {
      _setStatus(U.s.pleaseTurnOnYourPhonesNfcAndEnterAgain);
      await UNfc.openSettings();
      return;
    }
    try {
      await UNfcCard.start(aids: <String>[_aid], text: widget.valueToSend, onEvent: _onCardEvent);
      if (mounted)
        setState(() {
          ready = true;
          status = U.s.holdThePhoneBehindTheCardReader;
        });
    } on UNfcException catch (e) {
      _setStatus(U.s.errorStartingNfcMessage(e.message));
    }
  }

  void _onCardEvent(UNfcCardEvent event) {
    if (event.type == UNfcCardEventType.read && mounted)
      setState(() {
        sent = true;
        status = U.s.cardInformationWasSentSuccessfully;
        delay(1000, () => UNavigator.back());
      });
  }

  void _setStatus(String value) {
    if (mounted) setState(() => status = value);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return UScaffold(
      safeArea: false,
      body: Column(
        children: <Widget>[
          PageHeader(title: U.s.payWithNfc, subtitle: U.s.payWithDigitalCard),
          Expanded(
            child: UColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              padding: const EdgeInsets.all(24),
              spacing: 24,
              children: <Widget>[
                Icon(
                  sent ? Icons.check_circle_rounded : Icons.contactless_rounded,
                  size: 120,
                  color: sent ? scheme.primary : (ready ? scheme.secondary : scheme.outline),
                ),
                UTextTitleMedium(status, textAlign: TextAlign.center),
                if (ready && !sent) const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
