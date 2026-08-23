import "package:avreen_bank/model/account_model.dart";
import "package:avreen_bank/model/card_model.dart";
import "package:avreen_bank/model/transaction_model.dart";

class ProfileModel {
  const ProfileModel({
    required this.id,
    required this.badge,
    required this.name,
    required this.short,
    required this.meta,
    this.accounts = const <AccountModel>[],
    this.cards = const <CardModel>[],
    this.transactions = const <TransactionModel>[],
  });

  final String id;
  final String badge;
  final String name;
  final String short;
  final String meta;
  final List<AccountModel> accounts;
  final List<CardModel> cards;
  final List<TransactionModel> transactions;

  int get totalBalance => accounts.fold<int>(0, (int sum, AccountModel account) => sum + account.balance);
}
