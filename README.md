# ease_expense

A new Flutter project.

## Getting Started

after pulling the repo just need to do the usual steps

### open project directory:

```
flutter pub get && flutter run

```

## FEATURES

* Easy expense management
* GetX state management
* SQLite database for data persistence
* Local notifications for reminders (in progress)


## File struct : 

```
.
├── constants         # Holds constants
│   ├── const.dart
│   └── enums.dart
├── controllers       # GetX controllers
│   ├── accounts_controller.dart
│   ├── add_category_controller.dart
│   ├── categories_controller.dart
│   ├── dashboard_controller.dart
│   ├── home_controller.dart
│   ├── new_account_controller.dart
│   ├── new_trans_controller.dart
│   ├── trans_controller.dart
│   └── user_controller.dart
├── database          # Database related files
│   ├── controllers
│   │   └── db_controller.dart
│   └── sqlite
│       └── sqlite.dart
├── main.dart         # Main entry point of the application
├── models            # Data models
│   ├── accounts_model.dart
│   ├── category_model.dart
│   ├── dashboard_model.dart
│   ├── trans_model.dart
│   └── user_model.dart
├── screens           # Screens of the application
│   ├── accounts
│   │   ├── accounts_screen.dart
│   │   ├── new_account
│   │   │   └── new_account.dart
│   │   └── widgets
│   │       ├── account_list.dart
│   │       ├── accounts_dialog.dart
│   │       └── account_stats.dart
│   ├── categories
│   │   ├── add_edit_category_screen.dart
│   │   └── categories.dart
│   ├── dashboard
│   │   ├── dashboard_screen.dart
│   │   └── pie_chart.dart
│   ├── dialogs
│   │   └── list_dialog.dart
│   ├── home
│   │   └── home_screen.dart
│   ├── onboarding
│   │   └── onboarding_screen.dart
│   ├── transactions
│   │   ├── new_transaction.dart
│   │   ├── transactions_screen.dart
│   │   └── widgets
│   │       ├── date_chip.dart
│   │       ├── date_list_item.dart
│   │       └── monthly_stats_widget.dart
│   ├── user
│   │   └── settings.dart
│   └── widgets
│       ├── categories
│       │   └── category_list.dart
│       ├── category_type_selector.dart
│       ├── empty.dart
│       ├── fab.dart
│       ├── form_item.dart
│       ├── month_calender.dart
│       ├── stats_widget.dart
│       ├── tinkwell.dart
│       └── txn_text.dart
├── services          # Services
│   └── local_notification.dart
├── style             # Styles
│   ├── colors.dart
│   └── text_styles.dart
├── utils             # Utility functions
│   ├── extensions.dart
│   └── utils.dart
└── widgets           # Reusable widgets
    ├── delete_action.dart
    ├── focused_layout.dart
    ├── heading.dart
    └── wrapper.dart

```