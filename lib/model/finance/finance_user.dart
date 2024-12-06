import 'dart:convert';

class BudgetingModel {
  String id;
  String? name;
  String? email;
  String? password;
  double? balance;
  String? token;

  BudgetingModel({
    required this.id,
    this.name,
    this.email,
    this.password,
    this.balance,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'balance': balance,
      'token': token,
    };
  }

  factory BudgetingModel.fromMap(Map<String, dynamic> map) {
    return BudgetingModel(
      id: map['id'] ?? '',
      name: map['name'],
      email: map['email'],
      password: map['password'],
      balance: map['balance']?.toDouble(),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetingModel.fromJson(String source) =>
      BudgetingModel.fromMap(json.decode(source));
}
