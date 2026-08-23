import "package:u/utilities.dart";

enum TransactionDirection { credit, debit }

class TransactionModel {
  const TransactionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.direction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final int amount;
  final TransactionDirection direction;
}
