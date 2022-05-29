import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/models/package_model.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/screens/package_details_screen.dart';

class PackageDetailsArgs {
  final Package package;
  final Producer producer;

  PackageDetailsArgs({
    @required this.package,
    @required this.producer,
  });

  static PackageDetailsArgs fromJson(Map<String, dynamic> json) {
    return PackageDetailsArgs(
      package: json['package'],
      producer: json['producer'],
    );
  }
}

class PackageDetailsRoute
    extends NuRoute<NuRouter, PackageDetailsArgs, String> {
  @override
  Widget build(
      BuildContext context, NuRouteSettings<PackageDetailsArgs> settings) {
    return PackageDetailsScreen(
      producer: settings.args.producer,
      package: settings.args.package,
    );
  }

  @override
  ParamsParser<PackageDetailsArgs> get paramsParser =>
      PackageDetailsArgs.fromJson;

  @override
  String get path => 'package-details';

  @override
  ScreenType get screenType => materialScreenType;
}
