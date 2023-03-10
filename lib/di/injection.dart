import 'package:get_it/get_it.dart';

import './bloc_module.dart' as bloc_module;
import './repository_module.dart' as repository_module;
import './view_model_module.dart' as view_model_module;
import './network_module.dart' as network_module;

final GetIt injector = GetIt.instance;

Future<void> init() async {
  network_module.init(injector);

  repository_module.init(injector);

  view_model_module.init(injector);

  bloc_module.init(injector);
}
