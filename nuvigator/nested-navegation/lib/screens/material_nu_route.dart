import 'package:nuvigator/next.dart';

abstract class MaterialNuRoute<T extends NuRouter, A extends Object, R extends Object> extends NuRoute{

  @override
  ScreenType get screenType => materialScreenType;
}