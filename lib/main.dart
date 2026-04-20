import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/core/services/logger_service.dart';
import 'src/core/setup/service_locator.dart';
import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LoggerService.initialize();
  setupServiceLocator();
  runApp(const ProviderScope(child: App()));
}
