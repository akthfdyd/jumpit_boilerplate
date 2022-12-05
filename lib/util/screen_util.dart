import 'package:flutter/material.dart';

/// {@category Util}
getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// {@category Util}
getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// {@category Util}
/// Get rotation state.
isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

/// {@category Util}
/// Is this device a tablet pc or not.
isLargeScreen(BuildContext context) {
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  var shortSize =
      isPortrait ? getScreenWidth(context) : getScreenHeight(context);
  var isLargeScreen = shortSize > 600;
  return isLargeScreen;
}
