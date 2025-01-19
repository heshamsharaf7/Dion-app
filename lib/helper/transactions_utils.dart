import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';

class TransactionsUtils {
  static double calculateTotalDebt(List<TransactionsGetModel> transactions) {
    double totalDebt = 0;

    for (var transaction in transactions) {
      totalDebt += transaction.debit ?? 0;
    }

    return totalDebt;
  }

  static double calculateTotalCredit(List<TransactionsGetModel> transactions) {
    double totalCredit = 0;

    for (var transaction in transactions) {
      totalCredit += transaction.credit ?? 0;
    }

    return totalCredit;
  }

  static double calculateDebtForCurrentDay(
      List<TransactionsGetModel> transactions) {
    double totalDebtForCurrentDay = 0;

    // Get the current date
    final currentDate = DateTime.now();

    for (var transaction in transactions) {
      // Assuming enteredDate is a DateTime field
      if (DateTime.parse(transaction.enteredDate!).day == currentDate.day &&
          DateTime.parse(transaction.enteredDate!).month == currentDate.month &&
          DateTime.parse(transaction.enteredDate!).year == currentDate.year) {
        totalDebtForCurrentDay += transaction.debit ?? 0;
      }
    }

    return totalDebtForCurrentDay;
  }

  static double calculateCreditForCurrentDay(
      List<TransactionsGetModel> transactions) {
    double totalCreditForCurrentDay = 0;

    // Get the current date
    final currentDate = DateTime.now();

    for (var transaction in transactions) {
      // Assuming enteredDate is a DateTime field
      if (DateTime.parse(transaction.enteredDate!).day == currentDate.day &&
          DateTime.parse(transaction.enteredDate!).month == currentDate.month &&
          DateTime.parse(transaction.enteredDate!).year == currentDate.year) {
        totalCreditForCurrentDay += transaction.credit ?? 0;
      }
    }

    return totalCreditForCurrentDay;
  }
}
