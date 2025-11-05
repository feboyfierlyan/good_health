// Lokasi file: lib/util/config.dart

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConfig {
  static String get baseUrl {
    if (kIsWeb) {
      // Untuk Web (Chrome)
      return 'http://localhost/goodhealth';
    }
    if (Platform.isAndroid) {
      // Untuk Android Emulator
      return 'http://10.0.2.2/goodhealth';
    }
    if (Platform.isIOS) {
      // Untuk iOS Simulator
      return 'http://localhost/goodhealth';
    }
    // Default
    return 'http://localhost/goodhealth';
  }
}
