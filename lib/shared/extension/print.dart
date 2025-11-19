import 'package:flutter/material.dart';

void devPrint(String text, {PrintType type = PrintType.normal}) {
  switch (type) {
    case PrintType.normal:
      debugPrint(text);
      break;
    case PrintType.warning:
      devPrintWarning(text);
      break;
    case PrintType.error:
      devPrintError(text);
      break;
    case PrintType.success:
      devPrintSuccess(text);
      break;
    case PrintType.info:
      devPrintInfo(text);
      break;
    case PrintType.debug:
      devPrintDebug(text);
      break;
    case PrintType.notice:
      devPrintNotice(text);
    default:
  }
}

void devPrintWarning(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

void devPrintError(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

void devPrintSuccess(String text) {
  debugPrint('\x1B[32m$text\x1B[0m');
}

void devPrintInfo(String message) {
  debugPrint('\x1B[94m$message\x1B[0m'); // Blue
}

void devPrintDebug(String message) {
  debugPrint('\x1B[95m$message\x1B[0m'); // Magenta
}

void devPrintNotice(String message) {
  debugPrint('\x1B[96m$message\x1B[0m'); // Cyan
}

enum PrintType { normal, error, warning, success, info, debug, notice }
