import 'package:expense_tracker/controllers/new_expense_controller.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  NewExpenseController newExpenseController = Get.put(NewExpenseController());
  var titleController = TextEditingController().obs;
  var amountController = TextEditingController().obs;

  @override
  void dispose() {
    titleController.value.dispose();
    amountController.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(
            children: [
              TextField(
                controller: titleController.value,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Ürün"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController.value,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: "TL ",
                        label: Text("Fiyat"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(newExpenseController.selectDate.value == null
                            ? "Tarih Seçilmedi"
                            : formatter
                                .format(newExpenseController.selectDate.value)),
                        IconButton(
                          onPressed: () {
                            newExpenseController.presentDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Obx(() => Row(
                    children: [
                      DropdownButton(
                          value: newExpenseController.selectedCategory.value,
                          items: Category.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name.toUpperCase(),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            newExpenseController.selectedCategory.value = value;
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("İptal"),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: submitExpenseData,
                        child: const Text("Gideri Kaydet"),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.value.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.value.text.trim().isEmpty ||
        amountIsInvalid ||
        newExpenseController.selectDate == null) {
      Get.defaultDialog(
          title: "Geçersiz Giriş",
          content: const Text(
              "lütfen geçerli bir Başlık, Fiyat, Tarih ve Kategorinin girildiğinden emin olun"),
          confirmTextColor: Colors.white,
          actions: [
            SizedBox(width: 200),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Tamam"),
            ),
          ]);
      return;
    }

    widget.onAddExpense(
      ExpenseModel(
          title: titleController.value.text,
          amount: enteredAmount,
          date: newExpenseController.selectDate.value,
          category: newExpenseController.selectedCategory.value),
    );
  }
}
