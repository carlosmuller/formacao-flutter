import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/profile_screen.dart';

class ProfileRoute extends NuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return ProfileScreen();
  }

  @override
  String get path => 'profile';

  @override
  ScreenType get screenType => materialScreenType;
}
