import 'dart:io';

import 'package:arc/arc.dart';
import 'package:flutter/foundation.dart';
import 'package:jumpit_boilerplate/data/datasource/local/constant.dart';

enum LogLevel { v, d, i, w, e }

/// {@category Util}
class Log {
  static void log(String text, String prefix) {
    if (!kReleaseMode) {
      try {
        if (Platform.isAndroid) {
          // explain: android log length limit - sub text
          final pattern = RegExp('.{1,800}');
          pattern
              .allMatches(text)
              .forEach((match) => print(prefix + match.group(0)!));
        } else if (Platform.isIOS) {
          print(prefix + text);
        }
      } catch (error) {}
    }
  }

  /// logs for development
  static void v(String? text) {
    switch (Const.logLevel) {
      case LogLevel.v:
        log("$text", "devlog_v >> ");
        break;
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  /// for debug. connection, data logs
  static void d(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
        log("$text", "devlog_d >> ");
        break;
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  /// class lifecycle, method call
  static void i(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_i >> ");
        }
        break;
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  /// except case but not error
  static void w(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_w >> ");
        }
        var exception = OtherException("$text");
        var stack = StackTrace.current;

        log("${exception.toString()}", "devlog_w >> ");
        log("${stack.toString()}", "devlog_w >> ");
        break;
      case LogLevel.e:
        break;
    }
  }

  /// runtime error / exception
  static void e(exception, StackTrace stack, {String? text}) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_e >> ");
        }
        log("${exception.toString()}", "devlog_e >> ");
        log("${stack.toString()}", "devlog_e >> ");
        break;
    }
  }
}

class OtherException implements Exception {
  String cause;

  OtherException(this.cause);

  @override
  String toString() {
    return cause;
  }
}
