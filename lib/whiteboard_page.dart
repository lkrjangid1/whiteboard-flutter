import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_demo/whiteboard_view_model.dart';
import 'package:whiteboard_demo/widgets/tool_buttons.dart';

import 'widgets/whiteboard_view.dart';

class FireBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WhiteboardViewModel>(
      builder: (context, viewmodel, _) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                WhiteboardView(
                  lines: viewmodel.lines,
                  onGestureStart: viewmodel.onGestureStart,
                  onGestureUpdate: viewmodel.onGestureUpdate,
                  onGestureEnd: viewmodel.onGestureEnd,
                ),
                FireBoardToolButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteboardPageRoute extends MaterialPageRoute<void> {
  WhiteboardPageRoute(String id)
      : super(
          builder: (context) => ChangeNotifierProvider<WhiteboardViewModel>(
            create: (context) {
              final firestore = Provider.of<Firestore>(context, listen: false);
              return WhiteboardViewModel(firestore, id, 'whiteboard');
            },
            child: FireBoard(),
          ),
        );
}
