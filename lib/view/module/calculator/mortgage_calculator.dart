import 'package:flutter/material.dart';

class MortgageCalculator extends StatefulWidget {
  const MortgageCalculator({super.key});

  @override
  State<MortgageCalculator> createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  // Controllers for text fields
  final TextEditingController _hargaRumah = TextEditingController();
  final TextEditingController _uangMuka = TextEditingController();
  final TextEditingController _bunga = TextEditingController();
  final TextEditingController _jangkaWaktu = TextEditingController();
  final TextEditingController _pajak = TextEditingController();
  final TextEditingController _biayaLainnya = TextEditingController();

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
           
              Container(
                padding: EdgeInsets.all(padding),
                child: Text(  
                  "Kalkulator KPR",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dana Bulanan yang Dibutuhkan",
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
                title: "Harga Rumah",
                hint: "Harga Rumah",
                controller: _hargaRumah,
                isCurrency: true,
                fontSize: inputFontSize,
              ),
              butir_form(
                title: "Uang Muka",
                hint: "Uang Muka",
                controller: _uangMuka,
                isCurrency: true,
                fontSize: inputFontSize,
              ),
              if (screenWidth > 600)
                Row(
                  children: [
                    Expanded(
                      child: butir_form(
                        title: "Bunga (%)",
                        hint: "Bunga",
                        controller: _bunga,
                        isCurrency: false,
                        fontSize: inputFontSize,
                      ),
                    ),
                    SizedBox(width: padding), // Add spacing between fields
                    Expanded(
                      child: butir_form(
                        title: "Jangka Waktu (Tahun)",
                        hint: "Jangka Waktu",
                        controller: _jangkaWaktu,
                        isCurrency: false,
                        fontSize: inputFontSize,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
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
                  ],
                ),
              butir_form(
                title: "Pajak (%)",
                hint: "Pajak",
                controller: _pajak,
                isCurrency: false,
                fontSize: inputFontSize,
              ),
              butir_form(
                title: "Biaya Lainnya",
                hint: "Biaya Lainnya",
                controller: _biayaLainnya,
                isCurrency: true,
                fontSize: inputFontSize,
              ),
              SizedBox(height: padding),

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateMortgage,
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

  // Calculate the monthly mortgage payment
  void _calculateMortgage() {
    // Validate inputs
    if (_hargaRumah.text.isEmpty ||
        _uangMuka.text.isEmpty ||
        _bunga.text.isEmpty ||
        _jangkaWaktu.text.isEmpty ||
        _pajak.text.isEmpty ||
        _biayaLainnya.text.isEmpty) {
      _showAlert("Semua field harus diisi!");
      return;
    }

    // Parse inputs
    int hargaRumah =
        int.parse(_hargaRumah.text.replaceAll('.', '').replaceAll('Rp ', ''));
    int uangMuka =
        int.parse(_uangMuka.text.replaceAll('.', '').replaceAll('Rp ', ''));
    double bunga = double.parse(_bunga.text.replaceAll('%', '')) / 100;
    int jangkaWaktu = int.parse(_jangkaWaktu.text);
    double pajak = double.parse(_pajak.text.replaceAll('%', '')) / 100;
    int biayaLainnya =
        int.parse(_biayaLainnya.text.replaceAll('.', '').replaceAll('Rp ', ''));

    // Validate if down payment is less than house price
    if (uangMuka > hargaRumah) {
      _showAlert("Uang muka tidak boleh lebih besar dari harga rumah!");
      return;
    }

    // Calculate loan amount
    int loanAmount = hargaRumah - uangMuka;

    // Calculate monthly interest rate and number of payments
    double monthlyInterestRate = bunga / 12;
    int numberOfPayments = jangkaWaktu * 12;

    // Calculate monthly mortgage payment using the formula:
    // M = P * (r * (1 + r)^n) / ((1 + r)^n - 1)
    double monthlyPayment = loanAmount *
        (monthlyInterestRate *
            _pow(1 + monthlyInterestRate, numberOfPayments)) /
        (_pow(1 + monthlyInterestRate, numberOfPayments) - 1);

    // Add tax and other fees
    double totalMonthlyPayment =
        monthlyPayment + (monthlyPayment * pajak) + (biayaLainnya / 12);

    // Format the result as IDR
    setState(() {
      _hasilPerhitungan = formatToIDRFormat(totalMonthlyPayment.round());
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
          // padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              hintText: hint ?? "Harga Rumah",
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
