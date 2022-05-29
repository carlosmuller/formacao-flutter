import 'package:flutter/src/widgets/framework.dart';
import 'package:nested_nuvigators/screens/flows/first_flow/screen/one_screen.dart';
import 'package:nested_nuvigators/screens/flows/first_flow/screen/three_screen.dart';
import 'package:nested_nuvigators/screens/flows/first_flow/screen/two_screen.dart';
import 'package:nested_nuvigators/screens/material_nu_route.dart';
import 'package:nuvigator/next.dart';

class FirstFlowRoute extends MaterialNuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return Nuvigator(router: _FirstFlowRouter());
  }

  @override
  String get path => '/first-flow';

}

class _OneScreenRoute extends MaterialNuRoute{
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
   return OneScreen(
      onClose: () => nuvigator.closeFlow(),
      onNext: () => nuvigator.open('/first-flow/screen-2'),
    );
  }

  @override
  String get path => '/first-flow/screen-1';
}

class _SecondScreenRoute extends MaterialNuRoute{
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return TwoScreen(
      onClose: () => nuvigator.closeFlow(),
      onNext: () => nuvigator.open('/first-flow/screen-3'),
    );
  }

  @override
  String get path => '/first-flow/screen-2';
}

class _ThirdScreenRoute extends MaterialNuRoute{
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return ThreeScreen(
      onClose: () => nuvigator.closeFlow(),
      onNext: () => nuvigator.open('/second-flow'),
    );
  }

  @override
  String get path => '/first-flow/screen-3';
}
class _FirstFlowRouter extends NuRouter {

  @override
  String get initialRoute => '/first-flow/screen-1';

  @override
  List<NuRoute<NuRouter, Object, Object>> get registerRoutes => [
    _OneScreenRoute(),
    _SecondScreenRoute(),
    _ThirdScreenRoute()
  ];

}
