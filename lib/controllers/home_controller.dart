import 'package:get/get.dart';
import 'package:ease_expense/constants/enums.dart';

class HomeController extends GetxController {
  final Rx<HomeState> currentState = HomeState.transactions.obs;
}
