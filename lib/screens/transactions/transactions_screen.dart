import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ease_expense/constants/enums.dart';
import 'package:ease_expense/screens/dashboard/dashboard_screen.dart';
import 'package:ease_expense/screens/transactions/widgets/date_list_item.dart';
import 'package:ease_expense/screens/transactions/widgets/monthly_stats_widget.dart';
import 'package:ease_expense/screens/widgets/empty.dart';
import 'package:ease_expense/widgets/wrapper.dart';

import '../widgets/fab.dart';
import '../widgets/month_calender.dart';
import 'new_transaction.dart';
import '../../controllers/trans_controller.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: GetBuilder<TransController>(
        builder: (TransController controller) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const MonthCalender(),
              actions: [
                Obx(
                  () => Container(
                    child: controller.transactions.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                                onPressed: () {
                                  Get.to(() => const DashboardScreen(),
                                      arguments: controller.currentDate.value);
                                },
                                icon: const Icon(Icons.line_axis_outlined)),
                          ),
                  ),
                )
              ],
            ),
            body: Obx(() {
              if (controller.transactions.isEmpty &&
                  controller.transState.value != AppState.loading) {
                return const EmptyWidget(
                    assetName: "assets/img/no_txn.svg",
                    label: "No Transactions for the selected month");
              } else if (controller.transactions.isEmpty &&
                  controller.transState.value == AppState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 75),
                  shrinkWrap: true,
                  itemCount: controller.transactions.length + 1,
                  itemBuilder: (context, pos) {
                    if (pos == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: MonthlyStatsWidget(
                            monthlyStats: controller.monthlyStats),
                      );
                    }
                    return DateListItem(
                        date: controller.transactions.keys.elementAt(pos - 1),
                        transactions:
                            controller.transactions.values.elementAt(pos - 1));
                  });
            }),
            floatingActionButton: Fab(onTap: () {
              Get.to(() => NewTransaction());
            }),
          );
        },
      ),
    );
  }
}
