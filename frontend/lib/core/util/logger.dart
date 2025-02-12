import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
  ),
  level: kDebugMode ? Level.debug : Level.warning,
);

void setupLogging() {
  Logger.level = kDebugMode ? Level.debug : Level.warning;
}
