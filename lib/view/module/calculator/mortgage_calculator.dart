// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class MortgageCalculator extends StatefulWidget {
  const MortgageCalculator({super.key});

  @override
  State<MortgageCalculator> createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  TextEditingController hargaRumah = TextEditingController();
  TextEditingController uangMuka = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Kalkulator KPR",
              ),
              butir_form(
                  title: "Harga Rumah",
                  hint: "Harga Rumah",
                  controller: hargaRumah),
              butir_form(
                  title: "Uang Muka", hint: "Uang Muka", controller: uangMuka),
              butir_form(title: "Bunga", hint: "Bunga"),
              butir_form(title: "Jangka Waktu", hint: "Jangka Waktu"),
              butir_form(title: "Pajak", hint: "Pajak"),
              butir_form(title: "Biaya Lainnya", hint: "Biaya Lainnya"),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  String hargaRumah = this.hargaRumah.text;
                  String uangMuka = this.uangMuka.text;
                  debugPrint(
                      "Harga Rumah: $hargaRumah, Uang Muka: $uangMuka \n"
                      "Sisa Harga Rumah: ${int.parse(hargaRumah) - int.parse(uangMuka)}"
                  );

                  if (int.parse(hargaRumah) < int.parse(uangMuka)) {
                    // open dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Peringatan"),
                          content: Text("Harga rumah tidak boleh lebih kecil dari uang muka"),
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
                },
                child: Text("Hitung"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // todo!
  void calculateMorgage() {}

  // todo!
  void calculateTotalPrice() {}

  // todo!
  void validateInput() {}
  
  // todo!
  void showAlertIfInputInvalid() {}

  butir_form({String? title, String? hint, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title ?? "Belum ada title",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          controller: controller ?? hargaRumah,
          decoration: InputDecoration(
            hintText: hint ?? "Harga Rumah",
            hintStyle: TextStyle(
              color: Colors.grey,
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
      ],
    );
  }
}
