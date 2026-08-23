import "package:u/utilities.dart";

extension MoneyFormat on int {
  /// Group digits 3-by-3 and convert to Persian numerals (no unit suffix).
  String get money => separate3By3().toPersianNumber();
}
