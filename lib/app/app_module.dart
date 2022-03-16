import 'package:flutter_modular/flutter_modular.dart';

import 'hello_world_widget.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const HelloWorldWidget()),
      ];
}
