import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ease_expense/controllers/accounts_controller.dart';
import 'package:ease_expense/screens/accounts/new_account/new_account.dart';
import 'package:ease_expense/screens/widgets/stats_widget.dart';
import 'package:ease_expense/screens/widgets/txn_text.dart';
import 'package:ease_expense/widgets/heading.dart';

import '../../../models/accounts_model.dart';

class AccountList extends StatelessWidget {
  const AccountList({Key? key, required this.accountsMap}) : super(key: key);

  final RxMap<AccountType, List<Account>> accountsMap;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      AccountsController controller = Get.find();
      return ListView.builder(
          padding: const EdgeInsets.only(bottom: 75),
          itemCount: accountsMap.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, pos) {
            if (pos == 0) {
              return StatsWidget(statsMap: {
                "Assets": controller.totalAccountStat.assets,
                "Liabilities": controller.totalAccountStat.liabilities,
                "Total": controller.totalAccountStat.total,
              });
            }
            pos -= 1;
            List<Account> accounts = accountsMap.values.elementAt(pos);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(
                      title: accountTypeMap[accountsMap.keys.elementAt(pos)] ??
                          ""),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.all(0),
                    child: ListView.builder(
                        itemCount: accounts.length,
                        shrinkWrap: true,
                        itemBuilder: (context, pos) {
                          return AccountListItem(account: accounts[pos]);
                        }),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class AccountListItem extends StatelessWidget {
  const AccountListItem({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(NewAccount(), arguments: {"edit": true, "account": account});
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(account.accountName),
            account.accountType == AccountType.card
                ? TxnText(
                    amount: Get.find<AccountsController>()
                            .accountStats[account.id] ??
                        0,
                    customColor: Colors.white,
                  )
                : TxnText(
                    amount: Get.find<AccountsController>()
                            .accountStats[account.id] ??
                        0,
                  )
          ],
        ),
      ),
    );
  }
}
