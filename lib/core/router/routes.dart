class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const addEntry = '/add_entry';
  static const home = '/home';
  static const statistics = '/statistics';

  static String addIncome() => '$addEntry?type=income';
  static String addExpense() => '$addEntry?type=expense';
  static String editIncome(String id) =>
      '$addEntry?type=income&isEdit=true&id=$id';
  static String editExpense(String id) =>
      '$addEntry?type=expense&isEdit=true&id=$id';
}
