import 'package:get_it/get_it.dart';

import '../requests/utils/http_helper.dart';

/// A DI module for injecting http helper class

Future<void> init(GetIt injector) async {
  injector.registerFactory(() => HttpHelper());
}
