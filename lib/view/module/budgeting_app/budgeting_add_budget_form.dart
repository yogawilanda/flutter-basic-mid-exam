import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetingForm extends StatefulWidget {
  const BudgetingForm({super.key});

  @override
  State<BudgetingForm> createState() => _BudgetingFormState();
}

class _BudgetingFormState extends State<BudgetingForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedType = 'Income';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeting Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Add Budget',
                      style: GoogleFonts.poppins(fontSize: 24),
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        customFormTextField(),
                        dropDownInputs(selectedType ),
                        customFormTextField(
                            textController: amountController,
                            title: 'Amount',
                            hint: 'Enter amount'),
                        customFormTextField(
                            textController: dateController,
                            title: 'Date',
                            hint: 'Enter date'),
                        customFormTextField(
                            textController: categoryController,
                            title: 'Category',
                            hint: 'Enter category'),
                        customFormTextField(
                            textController: descriptionController,
                            title: 'Description',
                            hint: 'Enter description'),
                        // Button
                        ElevatedButton(
                          onPressed: () {
                            for (var controller in [
                              titleController,
                              amountController,
                              dateController,
                              categoryController,
                              descriptionController
                            ]) {
                              debugPrint(
                                  '${controller.runtimeType} : ${controller.text}');
                            }
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding dropDownInputs(String selectedType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButtonFormField<String>(
        hint: const Text('Select Type'),
        value: selectedType,
        decoration: InputDecoration(
          labelText: 'Transaction Type',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        dropdownColor: Colors.white,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        items: const [
          DropdownMenuItem(
            value: 'Income',
            child: Row(
              children: [
                Icon(Icons.arrow_circle_up, color: Colors.green),
                SizedBox(width: 8),
                Text('Income'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Expense',
            child: Row(
              children: const [
                Icon(Icons.arrow_circle_down, color: Colors.red),
                SizedBox(width: 8),
                Text('Expense'),
              ],
            ),
          ),
        ],
        onChanged: (String? value) {
          debugPrint('Value: $value');
        },
      ),
    );
  }

  customFormTextField(
      {TextEditingController? textController, String? title, String? hint}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController ?? titleController,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          labelText: title ?? 'Title',
          hintText: hint ?? 'Enter title',
          prefixIconColor: Colors.green,
          fillColor: Colors.green,
          focusColor: Colors.green,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
