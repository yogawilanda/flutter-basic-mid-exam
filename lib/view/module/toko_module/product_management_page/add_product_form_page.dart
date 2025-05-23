import 'package:flutter/material.dart';
import 'package:user_mortgage_app/view/widgets/text_field_custom.dart';

class AddProductFormPage extends StatelessWidget {
  AddProductFormPage({super.key});

  final TextEditingController _textEditingContName = TextEditingController();
  final TextEditingController _textEditingContPrice = TextEditingController();
  final TextEditingController _textEditingContStock = TextEditingController();
  final TextEditingController _textEditingContDescription =
      TextEditingController();

  // clean the controller
  void dispose() {
    _textEditingContName.clear();
    _textEditingContPrice.clear();
    _textEditingContStock.clear();
    _textEditingContDescription.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFieldCustom(
            textHint: 'Product Name',
            controller: _textEditingContName,
          ),
          TextFieldCustom(
            textHint: 'Product Price',
            controller: _textEditingContPrice,
          ),
          TextFieldCustom(
            textHint: 'Product Stock',
            controller: _textEditingContStock,
          ),
          TextFieldCustom(
            textHint: 'Product Description',
            controller: _textEditingContDescription,
          ),
          ElevatedButton(
            onPressed: () {
              var allController = [
                _textEditingContName,
                _textEditingContPrice,
              ];

              if (allController.every((element) => element.text.isNotEmpty)) {
                debugPrint(
                    'Product Price: ${_textEditingContPrice.text}\nProduct Name: ${_textEditingContName.text}\nProduct Stock: ${_textEditingContStock.text}\nProduct Description: ${_textEditingContDescription.text}');
              }

              dispose();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
