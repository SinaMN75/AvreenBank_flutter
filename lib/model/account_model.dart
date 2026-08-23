class AccountModel {
  const AccountModel({
    required this.badge,
    required this.title,
    required this.number,
    required this.balance,
    this.chips = const <String>[],
  });

  final String badge;
  final String title;
  final String number;
  final int balance;
  final List<String> chips;
}
