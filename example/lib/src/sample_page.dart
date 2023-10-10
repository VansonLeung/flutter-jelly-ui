


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  void _displayJellyDialog() {
    showDialog(context: context, builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      return JellyUiContainer(

        onWillPop: () {
          return Future(() => false);
        },

        child: Container(
          margin: EdgeInsets.fromLTRB(max(30, screenWidth * 0.1), max(30, screenHeight * 0.1), max(30, screenWidth * 0.1), max(30, screenHeight * 0.1)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 2.0,
              )
            ],
          ),

          child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Title here",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  SizedBox(height: 12,),

                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: 24,),


                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      JellyUiButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                        ),
                      ),


                      SizedBox(width: 24,),


                      JellyUiButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _displayJellyDialog();
                          });
                        },
                        child: Text(
                          'OK',
                        ),
                      ),
                    ],
                  )

                ],
              )
          ),

        ),
      );
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

            ElevatedButton(
                onPressed: () {},
                child: Text("Default Material Button"),
            ),

            JellyUiButton(
              onPressed: () { },
              child: Text(
                'Jelly Button 1',
              ),
            ),

            SizedBox(height: 20),

            JellyUiButton(
              onPressed: () { },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Jelly Button 2',
                  style: TextStyle(fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize),
                ),
              ),
            ),


            SizedBox(height: 20),


            JellyUiButton(
              onPressed: () {

                _displayJellyDialog();

              },
              child: Text(
                'Jelly Button 3',
              ),
            ),


            SizedBox(height: 20),

            ElevatedButton(onPressed: null, child: Text("ABC")),

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
