// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/view/widgets/horizontal_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Yoga_1201222013 extends StatefulWidget {
  const Yoga_1201222013(
      {super.key,
      this.title = "Hala",
      this.nim = "123456",
      this.nama = "Developer"});
  final String? title;
  final String? nim;
  final String? nama;

  @override
  State<Yoga_1201222013> createState() => _Yoga_1201222013State();
}

class _Yoga_1201222013State extends State<Yoga_1201222013> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  text({String content = "Kosong", FontWeight? fw}) {
    return Text(
      content,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyLarge,
        color: Colors.black87,
        fontWeight: fw,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyContent(context),
    );
  }

  Container actionContent(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: IconButton(
        icon: const Icon(Icons.image),
        color: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          _incrementCounter();
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary)),
      ),
    );
  }

  bodyContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            text(content: widget.title!, fw: FontWeight.bold),
            text(content: "${widget.nama} - ${widget.nim}"),
            HorizontalSlider(),
            cardContentName(context),
            // text(content: "Counter: $_counter"),
            // actionContent(context),
            // listTileWidget(context),
            // sliderContent(),
            // GridViewPlaceholder(),
          ],
        ),
      ),
    );
  }

  listTileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("List Tile Widget"),
          Container(
            constraints: BoxConstraints(
              // fixed height based on the remaining space
              maxHeight: MediaQuery.of(context).size.height * 0.2,
            ),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Item $index"),
                  subtitle: Text("Subtitle $index"),
                  leading: Icon(Icons.ac_unit),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // edit the the circular border
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          title: Text("Item $index"),
                          content: Text("Subtitle $index"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  sliderContent() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _counter % 2 == 0 ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "Counter: $_counter",
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  cardContentName(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: [
              Colors.deepPurple,
              Colors.deepPurple.shade400,
            ],
            stops: const [
              0.0,
              0.8
            ], // Adjust the stop values to control the gradient softness
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
            child: Text(
          "E A Yoga Wilanda",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
