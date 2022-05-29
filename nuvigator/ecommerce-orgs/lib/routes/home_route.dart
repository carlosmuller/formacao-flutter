import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/routes/producer_details_route.dart';
import 'package:proj/screens/home_screen.dart';

class HomeRoute extends NuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return HomeScreen(
      onProducerDetailsClick: (parameters) => nuvigator.open(ProducerDetailsRoute().path, parameters:  parameters)
    );
  }

  @override
  String get path => 'home';

  @override
  ScreenType get screenType => materialScreenType;
}
