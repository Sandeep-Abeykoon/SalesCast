import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab Bar Example'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Page 1'),
                Tab(text: 'Page 2'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('This is Page 1')),
              Center(child: Text('This is Page 2')),
            ],
          ),
        ),
      ),
    );
  }
}
