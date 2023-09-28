


import 'package:flutter/material.dart';
import 'package:flutter_jellyui/flutter_jellyui.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key, required this.title});
  final String title;

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            JellyUiButton(
              onPressed: () { },
              child: Text(
                'Button 1',
              ),
            ),

            SizedBox(height: 20),

            JellyUiButton(
              onPressed: () { },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Button 2',
                  style: TextStyle(fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize),
                ),
              ),
            ),

          ]
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          children: <Widget>[
            const Spacer(),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
