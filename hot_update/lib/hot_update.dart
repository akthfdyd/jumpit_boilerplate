// ignore_for_file: no_leading_underscores_for_local_identifiers
library hot_update;

import 'package:eval_annotation/eval_annotation.dart';
import 'package:flutter/material.dart';

@RuntimeOverride('#my_view')
Widget hotUpdateMyView(
  BuildContext context,
  String centerString,
  void Function() _onTapFloatingButton,
) {
  return Scaffold(
    body: Container(
      child: Center(
        child: Text(centerString),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _onTapFloatingButton,
      tooltip: 'love',
      child: const Icon(Icons.heart_broken),
    ),
  );
}
