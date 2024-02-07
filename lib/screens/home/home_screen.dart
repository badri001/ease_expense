import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ease_expense/constants/enums.dart';
import 'package:ease_expense/screens/accounts/accounts_screen.dart';
import 'package:ease_expense/controllers/home_controller.dart';
import 'package:ease_expense/controllers/trans_controller.dart';
import 'package:ease_expense/screens/transactions/transactions_screen.dart';
import 'package:ease_expense/screens/user/settings.dart';
import 'package:ease_expense/controllers/user_controller.dart';
import 'package:ease_expense/utils/utils.dart';
import 'package:ease_expense/widgets/wrapper.dart';

import '../categories/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final TransController transController = Get.put(TransController());
  final UserController userController = Get.find();
  String updateURL = "";
  String changelog = "";
  final _tabs = [
    const Transactions(),
    const Categories(),
    AccountsScreen(),
    UserSettings()
  ];

  Widget updateDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Update Available !!\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(changelog),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Utils.openLink(updateURL);
                      Get.back();
                    },
                    child: const Text(
                      "Download",
                    )),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("No , let it be"))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        int currentIndex = homeController.currentState.value.index;
        return ThemeWrapper(
          child: Scaffold(
            body: _tabs[homeController.currentState.value.index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                //   selectedItemColor: AppColors.accentColor,
                type: BottomNavigationBarType.fixed,
                // unselectedFontSize: 14,
                currentIndex: currentIndex,
                onTap: (newIndex) {
                  homeController.currentState.value =
                      HomeState.values[newIndex];
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_outlined),
                    label: 'Transactions',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet_outlined),
                    label: 'Accounts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: 'Settings',
                  ),
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }
}
