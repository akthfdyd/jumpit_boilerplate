import 'package:flutter/material.dart';

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

isPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

isLargeScreen(BuildContext context) {
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  var shortSize =
      isPortrait ? getScreenWidth(context) : getScreenHeight(context);
  var isLargeScreen = shortSize > 600;
  return isLargeScreen;
}
