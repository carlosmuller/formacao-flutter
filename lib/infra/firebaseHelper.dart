import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void sendToFireBase(Map<String, dynamic>? customKeys, error, stack) async {
  if (customKeys != null) {
    customKeys.entries.forEach((entry) async {
      await FirebaseCrashlytics.instance
          .setCustomKey(entry.key, entry.value);
    });
  }

  await FirebaseCrashlytics.instance.recordError(error, stack);
}
