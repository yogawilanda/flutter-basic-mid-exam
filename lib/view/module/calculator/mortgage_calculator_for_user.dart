import 'package:flutter/material.dart';

class MortgageCalculatorForUser extends StatefulWidget {
  const MortgageCalculatorForUser({super.key});

  @override
  State<MortgageCalculatorForUser> createState() => _MortgageCalculatorForUserState();
}

class _MortgageCalculatorForUserState extends State<MortgageCalculatorForUser> {
  // Controllers for text fields
  final TextEditingController _monthlyBudget = TextEditingController();
  final TextEditingController _bunga = TextEditingController();
  final TextEditingController _jangkaWaktu = TextEditingController();

  // Result of the calculation
  String _hasilPerhitungan = "Rp 0";

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding and font sizes based on screen width
    double padding = screenWidth < 600 ? 8.0 : 16.0;
    double titleFontSize = screenWidth < 600 ? 24.0 : 32.0;
    double resultFontSize = screenWidth < 600 ? 24.0 : 32.0;
    double inputFontSize = screenWidth < 600 ? 16.0 : 20.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Container(
                padding: EdgeInsets.all(padding),
                child: Text(
                  "Kalkulator KPR (Berdasarkan Budget Bulanan)",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Maximum Real Estate Value Result
              Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Harga Rumah Maksimal yang Dapat Dibeli",
                      style: TextStyle(
                        fontSize: inputFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _hasilPerhitungan,
                      style: TextStyle(
                        fontSize: resultFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Input Fields
              butir_form(
                title: "Budget Bulanan",
                hint: "Budget Bulanan",
                controller: _monthlyBudget,
                isCurrency: true,
                fontSize: inputFontSize,
              ),
              butir_form(
                title: "Bunga (%)",
                hint: "Bunga",
                controller: _bunga,
                isCurrency: false,
                fontSize: inputFontSize,
              ),
              butir_form(
                title: "Jangka Waktu (Tahun)",
                hint: "Jangka Waktu",
                controller: _jangkaWaktu,
                isCurrency: false,
                fontSize: inputFontSize,
              ),

              SizedBox(height: padding),

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateMaxHousePrice,
                child: Text(
                  "Hitung",
                  style: TextStyle(fontSize: inputFontSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Calculate the maximum house price based on monthly budget
  void _calculateMaxHousePrice() {
    // Validate inputs
    if (_monthlyBudget.text.isEmpty ||
        _bunga.text.isEmpty ||
        _jangkaWaktu.text.isEmpty) {
      _showAlert("Semua field harus diisi!");
      return;
    }

    // Parse inputs
    int monthlyBudget =
        int.parse(_monthlyBudget.text.replaceAll('.', '').replaceAll('Rp ', ''));
    double bunga = double.parse(_bunga.text.replaceAll('%', '')) / 100;
    int jangkaWaktu = int.parse(_jangkaWaktu.text);

    // Calculate monthly interest rate and number of payments
    double monthlyInterestRate = bunga / 12;
    int numberOfPayments = jangkaWaktu * 12;

    // Calculate the maximum loan amount using the formula:
    // P = M * ((1 + r)^n - 1) / (r * (1 + r)^n)
    double maxLoanAmount = monthlyBudget *
        (_pow(1 + monthlyInterestRate, numberOfPayments) - 1) /
        (monthlyInterestRate * _pow(1 + monthlyInterestRate, numberOfPayments));

    // Assuming the down payment is 20% of the house price
    double downPaymentPercentage = 0.2;
    double maxHousePrice = maxLoanAmount / (1 - downPaymentPercentage);

    // Format the result as IDR
    setState(() {
      _hasilPerhitungan = formatToIDRFormat(maxHousePrice.round());
    });
  }

  // Helper function to calculate power
  double _pow(double base, int exponent) {
    if (exponent == 0) return 1;
    double result = base;
    for (int i = 1; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  // Format integer to IDR currency
  String formatToIDRFormat(int amount) {
    String amountStr = amount.toString();
    String reversed = amountStr.split('').reversed.join('');
    String formatted = '';
    for (int i = 0; i < reversed.length; i++) {
      if (i != 0 && i % 3 == 0) {
        formatted += '.';
      }
      formatted += reversed[i];
    }
    formatted = formatted.split('').reversed.join('');
    return 'Rp $formatted';
  }

  // Show an alert dialog
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Peringatan"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Reusable input field widget
  Widget butir_form({
    String? title,
    String? hint,
    TextEditingController? controller,
    bool isCurrency = false,
    double fontSize = 16.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: fontSize / 4, horizontal: fontSize / 2),
          child: Text(
            title ?? "Belum ada title",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (isCurrency && value.isNotEmpty) {
                // Remove non-numeric characters
                String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                // Format as IDR
                String formattedValue =
                    formatToIDRFormat(int.parse(numericValue));
                // Update the controller value
                controller?.value = TextEditingValue(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                );
              }
            },
            style: TextStyle(fontSize: fontSize),
            decoration: InputDecoration(
              hintText: hint ?? "Budget Bulanan",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: fontSize,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}