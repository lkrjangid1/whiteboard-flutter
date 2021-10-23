import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_demo/whiteboard_page.dart';
import 'package:whiteboard_demo/widgets/tool_buttons.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider<Firestore>(
        create: (_) => Firestore.instance,
        child: MaterialApp(
          title: 'Whiteboard Demo',
          home: StartPage(),
        ),
      );
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter whiteboard id'),
              ),
              const SizedBox(height: 8),
              RaisedButton(
                onPressed: () {
                  final id =
                      _controller.text.isNotEmpty ? _controller.text : 'test';
                   Navigator.of(context).push(WhiteboardPageRoute(id));
                },
                child: Text('Connect'),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


