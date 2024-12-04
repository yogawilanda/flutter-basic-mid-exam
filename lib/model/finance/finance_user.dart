import 'dart:convert';

class UserFinanceModel {
  String id;
  String? name;
  String? email;
  String? password;
  // variable for current user balance in rupiah
  double? balance;
  String? token;

  UserFinanceModel({
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

  factory UserFinanceModel.fromMap(Map<String, dynamic> map) {
    return UserFinanceModel(
      id: map['id'] ?? '',
      name: map['name'],
      email: map['email'],
      password: map['password'],
      balance: map['balance']?.toDouble(),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFinanceModel.fromJson(String source) => UserFinanceModel.fromMap(json.decode(source));
}
