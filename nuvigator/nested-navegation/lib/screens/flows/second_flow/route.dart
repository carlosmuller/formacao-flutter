import 'package:flutter/src/widgets/framework.dart';
import 'package:nested_nuvigators/screens/flows/second_flow/screen/display_screen.dart';
import 'package:nested_nuvigators/screens/flows/second_flow/screen/input_screen.dart';
import 'package:nested_nuvigators/screens/material_nu_route.dart';
import 'package:nuvigator/next.dart';

class SecondFlowRoute extends MaterialNuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return Nuvigator(router: _SecondFlowRouter());
  }

  @override
  String get path => '/second-flow';
}

class _InputScreenRoute extends MaterialNuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return InputScreen(
      onNext: (String text) => nuvigator.open(
        '/second-flow/display',
        parameters: {'text': text},
      ),
    );
  }

  @override
  String get path => '/second-flow/input';
}

class _DisplayScreenRoute extends MaterialNuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return DisplayScreen(
      onClose: () => nuvigator.closeFlow(),
      text: settings.rawParameters['text'],
    );
  }

  @override
  String get path => '/second-flow/display';
}

class _SecondFlowRouter extends NuRouter {
  @override
  String get initialRoute => '/second-flow/input';

  @override
  List<NuRoute<NuRouter, Object, Object>> get registerRoutes => [
        _InputScreenRoute(),
        _DisplayScreenRoute(),
      ];
}
