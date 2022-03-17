import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/presenter/dimensions.dart';
import '../../../domain/entities/wall.dart';

class WallInfoCard extends StatelessWidget {
  final String name;
  final Wall wall;

  const WallInfoCard({
    Key? key,
    required this.wall,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: kMediumSpace),
            Row(
              children: [
                Expanded(
                  child: _buildPropertyDescription(
                    context,
                    name: 'Altura',
                    icon: const Icon(Icons.height_outlined),
                    description: '${wall.height} metros',
                  ),
                ),
                const SizedBox(width: kSmallSpace),
                Expanded(
                  child: _buildPropertyDescription(
                    context,
                    name: 'Largura',
                    icon: Transform.rotate(angle: pi / 2, child: const Icon(Icons.height_outlined)),
                    description: '${wall.width} metros',
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumSpace),
            Row(
              children: [
                Expanded(
                  child: _buildPropertyDescription(
                    context,
                    name: 'Portas',
                    icon: const Icon(Icons.door_back_door_outlined),
                    description: '${wall.doorsQuantity} unidades',
                  ),
                ),
                const SizedBox(width: kSmallSpace),
                Expanded(
                  child: _buildPropertyDescription(
                    context,
                    name: 'Janelas',
                    icon: const Icon(Icons.window_outlined),
                    description: '${wall.windowsQuantity} unidades',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyDescription(
    BuildContext context, {
    required String name,
    required Widget icon,
    required String description,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: kExtraSmallSpace),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name, style: textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: kExtraSmallSpace),
              Text(description),
            ],
          ),
        ],
      ),
    );
  }
}
