import 'package:flutter/cupertino.dart';

enum LogLevel { debug, warning, error, image }

abstract class LoggerClient {
  void onLog({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  });
}

class DebugLoggerClient implements LoggerClient {
  const DebugLoggerClient();

  String _formatMessage(LogLevel level, String message) {
    final timestamp = DateTime.now().toIso8601String();

    switch (level) {
      case LogLevel.debug:
        return 'ℹ️  [$timestamp] [DEBUG] $message';
      case LogLevel.warning:
        return '⚠️  [$timestamp] [WARNING] $message';
      case LogLevel.error:
        return '❌ [$timestamp] [ERROR] $message';
      case LogLevel.image:
        return '🖼️  [$timestamp] [IMAGE] $message';
    }
  }

  @override
  void onLog({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(_formatMessage(level, message));

    if (error != null) {
      debugPrint('Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
  }
}

class LoggerService {
  LoggerService._internal();

  static final LoggerService _instance = LoggerService._internal();
  static bool _initialized = false;
  static final List<LoggerClient> _clients = <LoggerClient>[];

  static LoggerService get instance => _instance;

  static void initialize() {
    if (_initialized) {
      return;
    }

    _instance.addClient(const DebugLoggerClient());
    _initialized = true;
    _instance.debug('Logger initialized');
  }

  void addClient(LoggerClient client) {
    if (_clients.contains(client)) {
      return;
    }
    _clients.add(client);
  }

  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _dispatch(
      level: LogLevel.debug,
      message: message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void info(String tag, String message) {
    debug('[$tag] $message');
  }

  void warning(String tag, String message) {
    _dispatch(level: LogLevel.warning, message: '[$tag] $message');
  }

  void error(String tag, String message, [StackTrace? stackTrace]) {
    _dispatch(
      level: LogLevel.error,
      message: '[$tag] $message',
      stackTrace: stackTrace,
    );
  }

  void _dispatch({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_clients.isEmpty) {
      debugPrint(message);
      if (error != null) {
        debugPrint(error.toString());
      }
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
      return;
    }

    for (final client in _clients) {
      client.onLog(
        level: level,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
