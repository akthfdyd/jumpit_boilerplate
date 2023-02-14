import 'package:flutter/material.dart';

/// {@category Component}
/// 공통 TextField로, 변경시 side effect 유의
TextField buildCommonTextField(Key key, bool isObscure, String label, String hint,
    [Function(String str)? onChanged]) {
  return TextField(
    key:key,
    obscureText: isObscure,
    decoration: InputDecoration(
      isDense: true,
      counterText: '',
      contentPadding: const EdgeInsets.only(bottom: 8),
      labelText: label,
      alignLabelWithHint: true,
      hintText: hint,
    ),
    onChanged: onChanged,
  );
}
