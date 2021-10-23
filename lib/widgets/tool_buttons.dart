import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../whiteboard_view_model.dart';

class FireBoardToolButtons extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final Color iconsEnableColor;
  final Color iconsDisableColor;
  final Color iconsColor;
  final double iconsSize;
  final double iconsRadious;
  final EdgeInsetsGeometry iconsPadding;
  const FireBoardToolButtons({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.iconsEnableColor = Colors.blueAccent,
    this.iconsDisableColor = Colors.black54,
    this.iconsColor = Colors.white,
    this.iconsSize = 20,
    this.iconsRadious = 20,
    this.iconsPadding = const EdgeInsets.symmetric(horizontal: 5),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<WhiteboardViewModel>(
      builder: (context, viewmodel, _) => Row(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Padding(
            padding: iconsPadding,
            child: CircleAvatar(
              radius: iconsRadious,
              backgroundColor: iconsEnableColor,
              child: PopupMenuButton(
                color: iconsColor,
                iconSize: iconsSize,
                tooltip: 'Line Type',
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: Text('Continuous line'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Dash line'),
                    ),
                  ];
                },
                onSelected: (index) {
                  if (index == 0) {
                    viewmodel.type = 'polygone';
                  } else if (index == 1) {
                    viewmodel.type = 'points';
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: iconsPadding,
            child: CircleAvatar(
              radius: iconsRadious,
              backgroundColor: viewmodel.color,
              child: IconButton(
                tooltip: 'Color picker',
                icon: Icon(Icons.colorize),
                color: iconsColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: Color(0xff000000),
                            onColorChanged: (color) {
                              viewmodel.color = color;
                            },
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(2.0),
                              topRight: const Radius.circular(2.0),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: iconsPadding,
            child: CircleAvatar(
              radius: iconsRadious,
              backgroundColor: viewmodel.tool == Tool.pen
                  ? iconsEnableColor
                  : iconsDisableColor,
              child: IconButton(
                tooltip: 'Pen Tool',
                icon: Icon(Icons.edit, size: iconsSize),
                color: iconsColor,
                onPressed: () => viewmodel.selectTool(Tool.pen, context),
              ),
            ),
          ),
          Padding(
            padding: iconsPadding,
            child: CircleAvatar(
              radius: iconsRadious,
              backgroundColor: viewmodel.tool == Tool.eraser
                  ? iconsEnableColor
                  : iconsDisableColor,
              child: IconButton(
                tooltip: 'Delete tool',
                icon: Icon(Icons.delete_outline, size: iconsSize),
                color: iconsColor,
                onPressed: () => viewmodel.selectTool(Tool.eraser, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
