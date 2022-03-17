import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/presenter/dimensions.dart';
import '../../../../../core/presenter/formatter.dart';
import '../../../domain/entities/wall.dart';
import 'wall_info_form.dart';

class WallInfoCard extends StatelessWidget {
  final String name;
  final Wall wall;
  final ValueChanged<Wall> onChanged;

  const WallInfoCard({
    Key? key,
    required this.wall,
    required this.name,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name, style: Theme.of(context).textTheme.headline6),
                const Spacer(),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 24,
                  onPressed: () => _showEditDialog(context),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumSpace),
            Row(
              children: [
                Expanded(
                  child: _PropertyDescription(
                    name: 'Altura',
                    icon: const Icon(Icons.height_outlined),
                    description: '${Formatter.simpleNumber(wall.height)} metros',
                  ),
                ),
                const SizedBox(width: kSmallSpace),
                Expanded(
                  child: _PropertyDescription(
                    name: 'Largura',
                    icon: Transform.rotate(angle: pi / 2, child: const Icon(Icons.height_outlined)),
                    description: '${Formatter.simpleNumber(wall.width)} metros',
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumSpace),
            Row(
              children: [
                Expanded(
                  child: _PropertyDescription(
                    name: 'Portas',
                    icon: const Icon(Icons.door_back_door_outlined),
                    description: '${wall.doorsQuantity} unidades',
                  ),
                ),
                const SizedBox(width: kSmallSpace),
                Expanded(
                  child: _PropertyDescription(
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

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
            child: Padding(
          padding: const EdgeInsets.all(kMediumSpace),
          child: WallInfoForm(
            identifier: name,
            initialValue: wall,
            onSaved: (newWall) {
              onChanged(newWall);
              Navigator.pop(context);
            },
          ),
        ));
      },
    );
  }
}

class _PropertyDescription extends StatelessWidget {
  final String name;
  final Widget icon;
  final String description;

  const _PropertyDescription({
    Key? key,
    required this.name,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
