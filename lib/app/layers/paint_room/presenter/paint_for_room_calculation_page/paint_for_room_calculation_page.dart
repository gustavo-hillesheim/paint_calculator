import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paint_calculator/app/core/presenter/formatter.dart';
import 'package:paint_calculator/app/layers/paint_room/domain/entities/room.dart';
import 'package:paint_calculator/app/layers/paint_room/presenter/paint_for_room_calculation_page/paint_for_room_calculation_controller.dart';
import 'package:paint_calculator/app/layers/paint_room/presenter/paint_for_room_calculation_page/widgets/paint_calculation_result.dart';

import '../../../../core/presenter/widgets/primary_button.dart';
import '../../../../core/presenter/dimensions.dart';
import '../../domain/entities/wall.dart';
import 'widgets/wall_info_card.dart';

class PaintForRoomCalculationPage extends StatefulWidget {
  const PaintForRoomCalculationPage({Key? key}) : super(key: key);

  @override
  State<PaintForRoomCalculationPage> createState() => _PaintForRoomCalculationPageState();
}

class _PaintForRoomCalculationPageState
    extends ModularState<PaintForRoomCalculationPage, PaintForRoomCalculationController> {
  late Wall wallOne;
  late Wall wallTwo;
  late Wall wallThree;
  late Wall wallFour;

  @override
  void initState() {
    super.initState();
    wallOne = _createInitialWall();
    wallTwo = _createInitialWall();
    wallThree = _createInitialWall();
    wallFour = _createInitialWall();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Wall _createInitialWall() {
    return const Wall(
      height: 1,
      width: 1,
      doorsQuantity: 0,
      windowsQuantity: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de tinta'),
        leading: const Icon(Icons.calculate_outlined),
        foregroundColor: theme.colorScheme.primary,
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kMediumSpace),
            child: Text(
              'Preencha as informações sobre a sala para poder calcular as latas de tinta necessárias para pintá-la',
              style: theme.textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: kMediumSpace),
              children: [
                WallInfoCard(
                  name: 'Parede 1',
                  wall: wallOne,
                  onChanged: (newWallOne) => setState(() {
                    wallOne = newWallOne;
                  }),
                ),
                const SizedBox(height: kMediumSpace),
                WallInfoCard(
                  name: 'Parede 2',
                  wall: wallTwo,
                  onChanged: (newWalltwo) => setState(() {
                    wallTwo = newWalltwo;
                  }),
                ),
                const SizedBox(height: kMediumSpace),
                WallInfoCard(
                  name: 'Parede 3',
                  wall: wallThree,
                  onChanged: (newWallThree) => setState(() {
                    wallThree = newWallThree;
                  }),
                ),
                const SizedBox(height: kMediumSpace),
                WallInfoCard(
                  name: 'Parede 4',
                  wall: wallFour,
                  onChanged: (newWallFour) => setState(() {
                    wallFour = newWallFour;
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kMediumSpace),
            child: Builder(builder: (context) {
              return PrimaryButton(
                onPressed: () => _calculatePaintBucketsNeeded(context),
                label: const Text('Calcular'),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _calculatePaintBucketsNeeded(BuildContext context) async {
    final room = Room(walls: [wallOne, wallTwo, wallThree, wallFour]);
    final calculationResult = await controller.calculate(room);

    calculationResult.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(failure.message, style: const TextStyle(color: Colors.red)),
      )),
      (paintBucketsNeeded) => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => PaintCalculationResult(
          buckets: paintBucketsNeeded,
          onTapOk: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
