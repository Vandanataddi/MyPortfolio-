// lib/investment_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Investment {
  String name;
  double amountInvested;
  double currentValue;

  Investment({
    required this.name,
    required this.amountInvested,
    required this.currentValue,
  });

  double get percentageGrowth =>
      ((currentValue - amountInvested) / amountInvested) * 100;

  Map<String, dynamic> toJson() => {
        'name': name,
        'amountInvested': amountInvested,
        'currentValue': currentValue,
      };

  static Investment fromJson(Map<String, dynamic> json) => Investment(
        name: json['name'],
        amountInvested: json['amountInvested'],
        currentValue: json['currentValue'],
      );
}

class InvestmentProvider with ChangeNotifier {
  List<Investment> _investments = [];
  double get totalPortfolioValue => _investments.fold(
      0, (sum, investment) => sum + investment.currentValue);

  List<Investment> get investments => _investments;

  Future<void> loadInvestments() async {
    final prefs = await SharedPreferences.getInstance();
    final savedInvestments = prefs.getStringList('investments') ?? [];
    _investments = savedInvestments
        .map((json) => Investment.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  Future<void> addInvestment(Investment investment) async {
    _investments.add(investment);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final savedInvestments =
        _investments.map((inv) => jsonEncode(inv.toJson())).toList();
    prefs.setStringList('investments', savedInvestments);
  }
}
