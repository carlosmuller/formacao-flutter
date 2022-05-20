// ignore_for_file: prefer_const_constructors
import 'package:bytebank/components/theme.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:bytebank/screens/name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    // Esta linha avisa a todas as instâncias do Crashlytics no projeto que ele não poderá registrar relatórios de erro
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setUserIdentifier("identificador");
  }
  
  BlocOverrides.runZoned(() {
    runApp(BytebankApp());
  }, blocObserver: LogObserver());
}

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: byteBankTheme,
      home: Dashboard(),
    );
  }
}
