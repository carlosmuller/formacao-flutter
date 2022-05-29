import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/routes/package_details_route.dart';
import 'package:proj/screens/producer_details_screen.dart';

class ProducerDetailsRoute extends NuRoute<NuRouter, ProducerDetailsArgs, String> {
  @override
  Widget build(BuildContext context, NuRouteSettings<ProducerDetailsArgs> settings) {
    return ProducerDetailsScreen(
      producer: settings.args.producer,
      onPackageClick: (parameters) =>
          nuvigator.open(PackageDetailsRoute().path, parameters: parameters),
    );
  }

  @override
  String get path => 'producer-details';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  ParamsParser<ProducerDetailsArgs> get paramsParser => ProducerDetailsArgs.fromJson;

}

class ProducerDetailsArgs {
  final Producer producer;

  ProducerDetailsArgs({@required this.producer});

  static ProducerDetailsArgs fromJson(Map<String, dynamic> json){
    return ProducerDetailsArgs(producer: json['producer']);
  }
}
