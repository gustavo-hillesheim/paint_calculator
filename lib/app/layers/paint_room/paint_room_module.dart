import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/paint_for_room_calculation_page/paint_for_room_calculation_page.dart';

class PaintRoomModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const PaintForRoomCalculationPage()),
      ];
}
