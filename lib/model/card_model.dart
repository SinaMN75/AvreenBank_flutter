import "package:avreen_bank/model/transaction_model.dart";

enum CardStatus { active, expiringSoon, blocked }

class CardModel {
  const CardModel({
    required this.id,
    required this.label,
    required this.title,
    required this.number,
    required this.holder,
    required this.expiry,
    required this.connectedAccount,
    this.balance = 0,
    this.status = CardStatus.active,
    this.transactions = const <TransactionModel>[],
  });

  final String id;
  final String label;
  final String title;
  final String number;
  final String holder;
  final String expiry;
  final String connectedAccount;
  final int balance;
  final CardStatus status;
  final List<TransactionModel> transactions;

  String get bin => number.length >= 6 ? number.substring(0, 6) : number;

  String get last4 => number.length >= 4 ? number.substring(number.length - 4) : number;
}
