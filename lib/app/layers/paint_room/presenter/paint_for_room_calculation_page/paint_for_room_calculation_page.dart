import 'package:flutter/material.dart';

import '../../../../core/presenter/dimensions.dart';
import '../../domain/entities/wall.dart';
import 'widgets/wall_info_card.dart';

class PaintForRoomCalculationPage extends StatelessWidget {
  const PaintForRoomCalculationPage({Key? key}) : super(key: key);

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
                const WallInfoCard(
                  name: 'Parede 1',
                  wall: Wall(
                    height: 3,
                    width: 5,
                    doorsQuantity: 1,
                    windowsQuantity: 2,
                  ),
                ),
                const SizedBox(height: kMediumSpace),
                const WallInfoCard(
                  name: 'Parede 2',
                  wall: Wall(
                    height: 3,
                    width: 5,
                    doorsQuantity: 1,
                    windowsQuantity: 2,
                  ),
                ),
                const SizedBox(height: kMediumSpace),
                const WallInfoCard(
                  name: 'Parede 3',
                  wall: Wall(
                    height: 3,
                    width: 5,
                    doorsQuantity: 1,
                    windowsQuantity: 2,
                  ),
                ),
                const SizedBox(height: kMediumSpace),
                const WallInfoCard(
                  name: 'Parede 4',
                  wall: Wall(
                    height: 3,
                    width: 5,
                    doorsQuantity: 1,
                    windowsQuantity: 2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kMediumSpace),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Calcular'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(
                  double.infinity,
                  44,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
