import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ease_expense/database/controllers/db_controller.dart';
import 'package:ease_expense/constants/enums.dart';
import 'package:ease_expense/screens/accounts/widgets/account_list.dart';
import 'package:ease_expense/controllers/accounts_controller.dart';
import 'package:ease_expense/screens/widgets/empty.dart';
import 'package:ease_expense/widgets/wrapper.dart';

import '../../widgets/focused_layout.dart';
import '../widgets/fab.dart';
import 'new_account/new_account.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({Key? key}) : super(key: key);
  final DbController dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: FocusedLayout(
        appBarTitle: "Accounts",
        fab: Fab(onTap: () {
          Get.to(() => NewAccount());
        }),
        child: GetBuilder<AccountsController>(
          init: AccountsController(),
          builder: (AccountsController controller) {
            return Obx(() {
              if (controller.accountsState.value == AppState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (dbController.accounts.isEmpty) {
                return const EmptyWidget(
                    assetName: "assets/img/no_acc.svg",
                    label: "No Accounts Found");
              }

              return AccountList(accountsMap: controller.accountList);
            });
          },
        ),
      ),
    );
  }
}
