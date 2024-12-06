import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/model/finance/finance_user.dart';

class BudgetingController extends ChangeNotifier {
  List<BudgetingModel> budgetList = [];
  double totalIncome = 0;
  double totalExpense = 0;
  double availableBalance = 2000;

  void addBudget(BudgetingModel budget) {
    budgetList.add(budget);
    notifyListeners();
  }

  void deleteBudget(BudgetingModel budget) {
    notifyListeners();
  }
  
}