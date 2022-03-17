import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/calculate_paint_needed_usecase.dart';
import 'domain/usecases/calculate_paint_needed_usecase_impl.dart';
import 'presenter/paint_for_room_calculation_page/paint_for_room_calculation_controller.dart';
import 'presenter/paint_for_room_calculation_page/paint_for_room_calculation_page.dart';

class PaintRoomModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind<CalculatePaintNeededUseCase>((i) => CalculatePaintNeededUseCaseImpl()),
        Bind((i) => PaintForRoomCalculationController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const PaintForRoomCalculationPage()),
      ];
}
