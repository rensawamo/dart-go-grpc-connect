import 'package:flutter/foundation.dart';

void printLongText(
  String text, {
  int lineLength = 800,
  StackTrace? stackTrace,
  String? code,
}) {
  if (text.isEmpty) {
    return;
  }

  final trimText = text.trim();
  for (var i = 0; i < trimText.length; i += lineLength) {
    debugPrint(
      trimText.substring(
        i,
        i + lineLength > trimText.length ? trimText.length : i + lineLength,
      ),
    );
  }

  if (code != null && code.isNotEmpty) {
    debugPrint('Error Code: $code');
  }

  if (stackTrace != null) {
    debugPrint('StackTrace:');
    for (var i = 0; i < stackTrace.toString().length; i += lineLength) {
      debugPrint(
        stackTrace.toString().substring(
              i,
              i + lineLength > stackTrace.toString().length
                  ? stackTrace.toString().length
                  : i + lineLength,
            ),
      );
    }
  }
}
