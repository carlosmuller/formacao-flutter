import 'package:flutter/material.dart';
import 'package:proj/core/app_colors.dart';
import 'package:proj/models/package_model.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/screens/favorites_screen.dart';
import 'package:proj/screens/home_screen.dart';
import 'package:proj/screens/login_screen.dart';
import 'package:proj/screens/package_details_screen.dart';
import 'package:proj/screens/payment_screen.dart';
import 'package:proj/screens/producer_details_screen.dart';
import 'package:proj/screens/profile_screen.dart';
import 'package:proj/screens/singup_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final routes = {
      'home': MaterialPageRoute(builder: (_) => HomeScreen()),
      'login': MaterialPageRoute(builder: (_) => LoginScreen()),
      'sing-up': MaterialPageRoute(builder: (_) => SingupScreen()),
      'favorites': MaterialPageRoute(builder: (_) => FavoritesScreen()),
      'profile': MaterialPageRoute(builder: (_) => ProfileScreen()),
      'payment': MaterialPageRoute(builder: (_) => PaymentScreen()),
      'producer-details': MaterialPageRoute(
        builder: (_) => args is Producer
            ? ProducerDetailsScreen(producer: args)
            : _errorRoute('argument expected to be a Producer but it was ${args.runtimeType}'),
      ),
      'package-details': MaterialPageRoute(
        builder: (_) => args is Map && args['package'] is Package && args['producer'] is Producer
            ? PackageDetailsScreen(package: args['package'], producer: args['producer'],)
            : _errorRoute('argument expected to have package and producer $args'),
      ),
    };
    return routes[settings.name]??_errorRoute();
  }

  static _errorRoute([String message]) {
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          title: Text(message?? 'Error'),
        ),
        body: Center(
          child: Text('Error ${message?? 'route not found'}'),
        ),
      );
    });
  }
}
