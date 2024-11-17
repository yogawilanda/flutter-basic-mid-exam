import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      this.title = "Hala",
      this.nim = "123456",
      this.nama = "Developer"});
  final String? title;
  final String? nim;
  final String? nama;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.nama} - ${widget.nim}",
              style: const TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
        actions: [
          Container(
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
          )
        ],
        forceMaterialTransparency: true,
      ),
      body: bodyContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Center bodyContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
