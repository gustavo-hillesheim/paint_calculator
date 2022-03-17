import 'package:flutter/material.dart';

import '../../../../core/presenter/widgets/primary_button.dart';
import '../../../../core/presenter/dimensions.dart';
import '../../domain/entities/wall.dart';
import 'widgets/wall_info_card.dart';

class PaintForRoomCalculationPage extends StatefulWidget {
  const PaintForRoomCalculationPage({Key? key}) : super(key: key);

  @override
  State<PaintForRoomCalculationPage> createState() => _PaintForRoomCalculationPageState();
}

class _PaintForRoomCalculationPageState extends State<PaintForRoomCalculationPage> {
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

  Wall _createInitialWall() {
    return const Wall(
      height: 3,
      width: 5,
      doorsQuantity: 1,
      windowsQuantity: 2,
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
            child: PrimaryButton(
              onPressed: _calculatePaintBucketsNeeded,
              label: const Text('Calcular'),
            ),
          ),
        ],
      ),
    );
  }

  void _calculatePaintBucketsNeeded() {}
}
