import 'package:flutter_modular/flutter_modular.dart';

import 'layers/paint_room/paint_room_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: PaintRoomModule()),
      ];
}
