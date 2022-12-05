import 'package:flutter/material.dart';

/// {@category DataSource}
class MockDataStore {
  static final MockDataStore _instance = MockDataStore._internal();
  static late AssetBundle asset;

  factory MockDataStore(BuildContext context) {
    asset = DefaultAssetBundle.of(context);
    return _instance;
  }

  MockDataStore._internal();
}
