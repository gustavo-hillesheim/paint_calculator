import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../../core/failure.dart';
import '../../../../core/presenter/widgets/primary_button.dart';
import '../../../../core/presenter/dimensions.dart';
import '../../domain/usecases/calculate_paint_needed_usecase.dart';
import '../../domain/entities/room.dart';
import '../../domain/entities/wall.dart';
import 'widgets/paint_calculation_result.dart';
import 'widgets/wall_info_card.dart';
import 'paint_for_room_calculation_controller.dart';

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
    final mediaQuery = MediaQuery.of(context);
    final isBigScreen = mediaQuery.size.width > 800;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isBigScreen ? 900 : double.infinity,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Calculadora de tinta'),
              leading: const Icon(Icons.calculate_outlined),
              foregroundColor: theme.colorScheme.primary,
              titleSpacing: 0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMediumSpace),
                  child: Text(
                    'Preencha as informações sobre a sala para poder calcular as latas de tinta necessárias para pintá-la',
                    style: theme.textTheme.headline6,
                  ),
                ),
                Expanded(
                  child: isBigScreen ? _buildTwoColumnWallList() : _buildSingleColumnWallList(),
                ),
                if (isBigScreen) ...[
                  _buildResultStreamBuilder(),
                  const SizedBox(height: kMediumSpace),
                ],
                Padding(
                  padding: const EdgeInsets.all(kMediumSpace),
                  child: Builder(builder: (context) {
                    return PrimaryButton(
                      onPressed: () => _calculatePaintBucketsNeeded(context, isBigScreen),
                      label: const Text('Calcular'),
                      size: isBigScreen ? ButtonSize.large : ButtonSize.expanded,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleColumnWallList() {
    return ListView(
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
    );
  }

  Widget _buildTwoColumnWallList() {
    const maxCardWidth = 350.0;
    const cardConstraints = BoxConstraints(maxWidth: maxCardWidth);

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: kMediumSpace),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: cardConstraints,
              child: WallInfoCard(
                name: 'Parede 1',
                wall: wallOne,
                onChanged: (newWallOne) => setState(() {
                  wallOne = newWallOne;
                }),
              ),
            ),
            const SizedBox(width: kMediumSpace),
            ConstrainedBox(
              constraints: cardConstraints,
              child: WallInfoCard(
                name: 'Parede 2',
                wall: wallTwo,
                onChanged: (newWalltwo) => setState(() {
                  wallTwo = newWalltwo;
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: kMediumSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: cardConstraints,
              child: WallInfoCard(
                name: 'Parede 3',
                wall: wallThree,
                onChanged: (newWallThree) => setState(() {
                  wallThree = newWallThree;
                }),
              ),
            ),
            const SizedBox(width: kMediumSpace),
            ConstrainedBox(
              constraints: cardConstraints,
              child: WallInfoCard(
                name: 'Parede 4',
                wall: wallFour,
                onChanged: (newWallFour) => setState(() {
                  wallFour = newWallFour;
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultStreamBuilder() {
    return StreamBuilder<Either<Failure, List<PaintBucketNeeded>>>(
      stream: controller.stream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: ${snapshot.error.toString()}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        final result = snapshot.data!;
        if (result.isLeft()) {
          final failure = result.getLeft().toNullable()!;
          return Center(
            child: Text(
              'Erro: ${failure.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final buckets = result.getRight().toNullable()!;
          return PaintCalculationResult(
            buckets: buckets,
            onTapOk: null,
            small: true,
          );
        }
      },
    );
  }

  void _calculatePaintBucketsNeeded(BuildContext context, bool isBigScreen) async {
    final room = Room(walls: [wallOne, wallTwo, wallThree, wallFour]);
    final calculationResult = await controller.calculate(room);

    if (!isBigScreen) {
      calculationResult.fold(
        (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(failure.message, style: const TextStyle(color: Colors.red)),
        )),
        (paintBucketsNeeded) => _showResultBottomSheet(context, paintBucketsNeeded),
      );
    }
  }

  void _showResultBottomSheet(BuildContext context, List<PaintBucketNeeded> paintBucketsNeeded) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(kMediumSpace),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(kMediumSpace)),
        ),
        child: PaintCalculationResult(
          buckets: paintBucketsNeeded,
          onTapOk: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
