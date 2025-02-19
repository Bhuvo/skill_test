import 'package:flutter/material.dart';

class LocalSizeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) builder;
  LocalSizeBuilder({Key? key, required this.builder}) : super(key: key);
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        size = Size(constraints.maxWidth, constraints.maxHeight);
        return builder(context, size);
      },
    );
  }
}
