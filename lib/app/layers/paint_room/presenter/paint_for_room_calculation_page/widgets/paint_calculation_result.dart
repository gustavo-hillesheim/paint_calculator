import 'package:flutter/material.dart';

import '../../../../../core/presenter/widgets/primary_button.dart';
import '../../../../../core/presenter/dimensions.dart';
import '../../../../../core/presenter/formatter.dart';
import '../../../domain/usecases/calculate_paint_needed_usecase.dart';

class PaintCalculationResult extends StatelessWidget {
  final List<PaintBucketNeeded> buckets;
  final VoidCallback onTapOk;

  const PaintCalculationResult({
    Key? key,
    required this.buckets,
    required this.onTapOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(kMediumSpace),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kMediumSpace)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.format_paint_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: kSmallSpace),
              Text('Resultado', style: theme.textTheme.headline6),
            ],
          ),
          const SizedBox(height: kMediumSpace),
          for (final paintBucketNeeded in buckets) ...[
            Text(
              '${paintBucketNeeded.quantity} x balde de '
              '${Formatter.simpleNumber(paintBucketNeeded.bucket.liters)} litros',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: kExtraSmallSpace),
          ],
          const SizedBox(height: kMediumSpace - kExtraSmallSpace),
          PrimaryButton(
            label: const Text('OK'),
            onPressed: onTapOk,
          ),
        ],
      ),
    );
  }
}
