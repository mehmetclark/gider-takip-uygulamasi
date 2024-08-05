import 'package:expense_tracker/controllers/new_expense_controller.dart';
import 'package:expense_tracker/extensions/context_extension.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  static const String routename = "/expenses";

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final NewExpenseController controller = Get.put(NewExpenseController());
  var kColorScheme =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255));

  @override
  Widget build(BuildContext context) {
    final width = context.mediaQueryWidth;
    final height = context.mediaQueryHeight;

    Widget mainContent = const Center(
      child: Text("Gider Bulunamadı. Lütfen Gider Ekleyin !"),
    );
    if (controller.registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: controller.registeredExpenses,
        onRemoveExpense: removeExpence,
      );
    }

    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: const Text(
            "Gider Takip Uygulaması",
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add, color: Colors.red)),
          ],
        ),
        body: width <= 600
            ? Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Tema Değiştir",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Obx(
                          () => Switch(
                            value: controller.thema.value,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              controller.thema.value = value;
                              Get.changeTheme(
                                Get.isDarkMode
                                    ? ThemeData.light().copyWith(
                                        useMaterial3: true,
                                        colorScheme: kColorScheme,
                                        appBarTheme: AppBarTheme().copyWith(
                                            backgroundColor:
                                                kColorScheme.onPrimaryContainer,
                                            foregroundColor:
                                                kColorScheme.primaryContainer),
                                        scaffoldBackgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        cardTheme: CardTheme().copyWith(
                                            color:
                                                kColorScheme.secondaryContainer,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8)),
                                        elevatedButtonTheme:
                                            ElevatedButtonThemeData(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        kColorScheme
                                                            .primaryContainer)),
                                      )
                                    : ThemeData.dark().copyWith(
                                        useMaterial3: true,
                                        cardTheme: CardTheme().copyWith(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8)),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Chart(expenses: controller.registeredExpenses),
                    Expanded(
                      child: mainContent,
                    )
                  ],
                ),
              )
            : Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Chart(expenses: controller.registeredExpenses),
                  )),
                  Expanded(
                    child: mainContent,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tema Değiştir",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Obx(
                        () => Switch(
                          value: controller.thema.value,
                          activeColor: Colors.blue,
                          onChanged: (bool value) {
                            controller.thema.value = value;
                            Get.changeTheme(
                              Get.isDarkMode
                                  ? ThemeData.light().copyWith(
                                      useMaterial3: true,
                                      colorScheme: kColorScheme,
                                      appBarTheme: AppBarTheme().copyWith(
                                          backgroundColor:
                                              kColorScheme.onPrimaryContainer,
                                          foregroundColor:
                                              kColorScheme.primaryContainer),
                                      scaffoldBackgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      cardTheme: CardTheme().copyWith(
                                          color:
                                              kColorScheme.secondaryContainer,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8)),
                                      elevatedButtonTheme:
                                          ElevatedButtonThemeData(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kColorScheme
                                                      .primaryContainer)),
                                    )
                                  : ThemeData.dark().copyWith(
                                      useMaterial3: true,
                                      cardTheme: CardTheme().copyWith(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8)),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true, // Bottom sheet tüm ekranı kaplamasını sağlar
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: addExpense);
        });
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      controller.registeredExpenses.add(expense);
    });
  }

  void removeExpence(ExpenseModel expense) {
    final ExpenseIndex = controller.registeredExpenses.indexOf(expense);
    setState(() {
      controller.registeredExpenses.remove(expense);
    });

    Get.snackbar("Gideri silmek üzeresiniz", "Gider Silindi",
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        backgroundColor: Colors.white,
        mainButton: TextButton(
          onPressed: () {
            setState(() {
              controller.registeredExpenses.insert(ExpenseIndex, expense);
            });
            Get.closeCurrentSnackbar();
          },
          child: Text("Geri Al"),
        ));
  }
}
