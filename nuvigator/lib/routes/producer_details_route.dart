import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/routes/package_details_route.dart';
import 'package:proj/screens/producer_details_screen.dart';

class ProducerDetailsRoute extends NuRoute {
  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return ProducerDetailsScreen(
      producer: settings.rawParameters['producer'],
      onPackageClick: (parameters) =>
          nuvigator.open(PackageDetailsRoute().path, parameters: parameters),
    );
  }

  @override
  String get path => 'producer-details';

  @override
  ScreenType get screenType => materialScreenType;
}
