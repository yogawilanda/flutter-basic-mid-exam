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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeting Form'),
      ),
      body: Column(
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
                            debugPrint(controller.text);
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
    );
  }

  TextFormField customFormTextField(
      {TextEditingController? textController, String? title, String? hint}) {
    return TextFormField(
      controller: textController ?? titleController,
      decoration: InputDecoration(
        labelText: title ?? 'Title',
        hintText: hint ?? 'Enter title',
      ),
    );
  }
}
