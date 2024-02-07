import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ease_expense/style/colors.dart';
import 'package:ease_expense/database/controllers/db_controller.dart';
import 'package:ease_expense/constants/enums.dart';
import 'package:ease_expense/screens/home/home_screen.dart';
import 'package:ease_expense/screens/onboarding/onboarding_screen.dart';
import 'package:ease_expense/widgets/wrapper.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// final NotificationManager notificationManager =
//     NotificationManager(flutterLocalNotificationsPlugin);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await notificationManager.initNotifications();
  // await notificationManager.scheduleNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      if (darkDynamic != null) {
        AppColors.monetColorScheme = darkDynamic;
      }

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppColors.defaultTheme,
        themeMode: ThemeMode.dark,
        darkTheme:
            darkDynamic != null ? AppColors.monetTheme : AppColors.defaultTheme,
        title: 'Ease Expense',
        home: GetBuilder<DbController>(
          init: DbController(),
          // initState: (state){
          //   state.controller?.initDB();
          // },
          builder: (dbController) {
            return Obx(() {
              if (dbController.appState.value == AppState.loading) {
                return const ThemeWrapper(
                  child: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else {
                if (dbController.isNew.value) {
                  return OnBoardingScreen();
                }
                return const ThemeWrapper(child: HomeScreen());
              }
            });
          },
        ),
      );
    });
  }
}
