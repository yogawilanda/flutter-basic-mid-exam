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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "Kalkulator KPR",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Monthly Payment Result
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dana Bulanan yang Dibutuhkan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _hasilPerhitungan,
                      style: const TextStyle(
                        fontSize: 24,
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
              ),
              butir_form(
                title: "Uang Muka",
                hint: "Uang Muka",
                controller: _uangMuka,
                isCurrency: true,
              ),
              butir_form(
                title: "Bunga (%)",
                hint: "Bunga",
                controller: _bunga,
                isCurrency: false,
              ),
              butir_form(
                title: "Jangka Waktu (Tahun)",
                hint: "Jangka Waktu",
                controller: _jangkaWaktu,
                isCurrency: false,
              ),
              butir_form(
                title: "Pajak (%)",
                hint: "Pajak",
                controller: _pajak,
                isCurrency: false,
              ),
              butir_form(
                title: "Biaya Lainnya",
                hint: "Biaya Lainnya",
                controller: _biayaLainnya,
                isCurrency: true,
              ),
              const SizedBox(height: 8),

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateMortgage,
                child: const Text("Hitung"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Calculate the monthly mortgage payment
  // void _calculateMortgage() {
  //   // Validate inputs
  //   if (_hargaRumah.text.isEmpty ||
  //       _uangMuka.text.isEmpty ||
  //       _bunga.text.isEmpty ||
  //       _jangkaWaktu.text.isEmpty ||
  //       _pajak.text.isEmpty ||
  //       _biayaLainnya.text.isEmpty) {
  //     _showAlert("Semua field harus diisi!");
  //     return;
  //   }

  //   // Parse inputs
  //   int hargaRumah =
  //       int.parse(_hargaRumah.text.replaceAll('.', '').replaceAll('Rp ', ''));
  //   int uangMuka =
  //       int.parse(_uangMuka.text.replaceAll('.', '').replaceAll('Rp ', ''));
  //   double bunga = double.parse(_bunga.text.replaceAll('%', '')) / 100;
  //   int jangkaWaktu = int.parse(_jangkaWaktu.text);
  //   double pajak = double.parse(_pajak.text.replaceAll('%', '')) / 100;
  //   int biayaLainnya =
  //       int.parse(_biayaLainnya.text.replaceAll('.', '').replaceAll('Rp ', ''));

  //   // Validate if down payment is less than house price
  //   if (uangMuka > hargaRumah) {
  //     _showAlert("Uang muka tidak boleh lebih besar dari harga rumah!");
  //     return;
  //   }

  //   // Calculate loan amount
  //   int loanAmount = hargaRumah - uangMuka;

  //   // Calculate monthly interest rate and number of payments
  //   double monthlyInterestRate = bunga / 12;
  //   int numberOfPayments = jangkaWaktu * 12;

  //   // Calculate monthly mortgage payment using the formula:
  //   // M = P * (r * (1 + r)^n) / ((1 + r)^n - 1)
  //   double monthlyPayment = loanAmount *
  //       (monthlyInterestRate *
  //           _pow(1 + monthlyInterestRate, numberOfPayments)) /
  //       (_pow(1 + monthlyInterestRate, numberOfPayments) - 1);

  //   // Add tax and other fees
  //   double totalMonthlyPayment =
  //       monthlyPayment + (monthlyPayment * pajak) + (biayaLainnya / 12);

  //   // Format the result as IDR
  //   setState(() {
  //     _hasilPerhitungan = formatToIDRFormat(totalMonthlyPayment.round());
  //   });
  // }
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

    // Debug print input values
    debugPrint("Harga Rumah: $hargaRumah");
    debugPrint("Uang Muka: $uangMuka");
    debugPrint("Bunga: $bunga");
    debugPrint("Jangka Waktu: $jangkaWaktu tahun");
    debugPrint("Pajak: $pajak");
    debugPrint("Biaya Lainnya: $biayaLainnya");

    // Validate if down payment is less than house price
    if (uangMuka > hargaRumah) {
      _showAlert("Uang muka tidak boleh lebih besar dari harga rumah!");
      return;
    }

    // Calculate loan amount
    int loanAmount = hargaRumah - uangMuka;
    debugPrint("Loan Amount (Pinjaman): $loanAmount");

    // Calculate monthly interest rate and number of payments
    double monthlyInterestRate = bunga / 12;
    int numberOfPayments = jangkaWaktu * 12;
    debugPrint("Monthly Interest Rate: $monthlyInterestRate");
    debugPrint("Number of Payments: $numberOfPayments");

    // Calculate monthly mortgage payment using the formula:
    // M = P * (r * (1 + r)^n) / ((1 + r)^n - 1)
    double numerator =
        monthlyInterestRate * _pow(1 + monthlyInterestRate, numberOfPayments);
    double denominator = _pow(1 + monthlyInterestRate, numberOfPayments) - 1;
    double monthlyPayment = loanAmount * (numerator / denominator);
    debugPrint(
        "Monthly Payment (Sebelum Pajak & Biaya Lainnya): $monthlyPayment");

    // Add tax and other fees
    double totalMonthlyPayment =
        monthlyPayment + (monthlyPayment * pajak) + (biayaLainnya / 12);
    debugPrint(
        "Total Monthly Payment (Setelah Pajak & Biaya Lainnya): $totalMonthlyPayment");

    // Format the result as IDR
    setState(() {
      _hasilPerhitungan = formatToIDRFormat(totalMonthlyPayment.round());
    });

    // Debug print final result
    debugPrint("Hasil Perhitungan: $_hasilPerhitungan");
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
          title: const Text("Peringatan"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title ?? "Belum ada title",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
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
          decoration: InputDecoration(
            hintText: hint ?? "Harga Rumah",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
