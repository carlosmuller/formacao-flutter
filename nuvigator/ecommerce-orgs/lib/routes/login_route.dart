import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/routes/home_route.dart';
import 'package:proj/routes/singup_route.dart';
import 'package:proj/screens/login_screen.dart';

class LoginRoute extends NuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return LoginScreen(
      onLoginClick: () => nuvigator.open(HomeRoute().path),
      onSingupClick: () => nuvigator.open(SingupRoute().path),
    );
  }

  @override
  String get path => 'login';

  @override
  ScreenType get screenType => materialScreenType;
}
