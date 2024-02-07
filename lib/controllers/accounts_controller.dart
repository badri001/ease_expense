import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:ease_expense/constants/const.dart';
import 'package:ease_expense/database/controllers/db_controller.dart';

import '../constants/enums.dart';
import '../models/accounts_model.dart';

class AccountsController extends GetxController {
  RxMap<int, double> accountStats = <int, double>{}.obs;
  Rx<AppState> accountsState = AppState.loading.obs;
  RxMap<AccountType, List<Account>> accountList =
      <AccountType, List<Account>>{}.obs;
  TotalAccountStat totalAccountStat = TotalAccountStat();

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    accountStats.clear();
    totalAccountStat = TotalAccountStat();
    DbController dbController = Get.find();
    var statsList = await dbController.db
        .rawQuery("""SELECT account_id, SUM(amount) as total
      FROM ${Const.trans} GROUP BY account_id""");
    accountStats.value = Map<int, double>.fromEntries(statsList.map((e) {
      return MapEntry<int, double>(
          e['account_id'] as int, e['total'] as double);
    }));
    accountStats.removeWhere(
        (key, value) => dbController.accounts[key]?.isDeleted == 1);
    Map<int, double> tempAccountStats = {...accountStats};
    accountStats.forEach((id, value) {
      Account account = dbController.accounts[id]!;
      if (account.parentId != null) {
        tempAccountStats[account.parentId!] =
            (tempAccountStats[account.parentId] ?? 0) + value;
      }
    });
    accountStats.value = tempAccountStats;
    List<int> linkedAccountIds = <int>[];
    accountStats.forEach((id, value) {
      Account account = dbController.accounts[id]!;
      if (!account.hasParentAccount()) {
        if (value.isNegative) {
          totalAccountStat.liabilities += value;
        } else {
          totalAccountStat.assets += value;
        }
      } else {
        accountStats[id] = 0;
        linkedAccountIds.add(account.id!);
      }
    });
    statsList = await dbController.db
        .rawQuery("""SELECT account_id, SUM(amount) as total
      FROM ${Const.trans} WHERE created_at BETWEEN ${getFirstDate()}
      AND ${DateTime.now().millisecondsSinceEpoch} AND account_id in (${linkedAccountIds.join(",")})
      GROUP BY account_id""");
    accountStats.addAll(Map<int, double>.fromEntries(statsList.map((e) {
      return MapEntry<int, double>(
          e['account_id'] as int, e['total'] as double);
    })));
    accountStats.removeWhere(
        (key, value) => dbController.accounts[key]?.isDeleted == 1);
    List<Account> tempAccountList = dbController.accounts.values.toList();
    tempAccountList.removeWhere((account) => account.isDeleted == 1);
    Map<AccountType, List<Account>> temp = groupBy<Account, AccountType>(
        tempAccountList, (account) => account.accountType);
    accountList.value = temp;
    totalAccountStat.total =
        totalAccountStat.assets + totalAccountStat.liabilities;
    accountsState.value = AppState.loaded;
  }

  int getFirstDate() {
    return DateTime.now()
        .copyWith(day: 1, hour: 0, minute: 0, second: 0, microsecond: 1)
        .millisecondsSinceEpoch;
  }
}
