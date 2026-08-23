import "package:avreen_bank/model/transaction_model.dart";

enum CardStatus { active, expiringSoon, blocked }

class CardModel {
  const CardModel({
    required this.id,
    required this.label,
    required this.title,
    required this.pan,
    required this.expiry,
    required this.balance,
    required this.connectedAccount,
    this.status = CardStatus.active,
    this.transactions = const <TransactionModel>[],
  });

  final String id;
  final String label;
  final String title;
  final String pan;
  final String expiry;
  final int balance;
  final String connectedAccount;
  final CardStatus status;
  final List<TransactionModel> transactions;
}
