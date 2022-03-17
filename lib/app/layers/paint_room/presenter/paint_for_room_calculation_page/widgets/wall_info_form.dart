import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/presenter/parser.dart';
import '../../../../../core/presenter/validator.dart';
import '../../../../../core/presenter/dimensions.dart';
import '../../../../../core/presenter/formatter.dart';
import '../../../../../core/presenter/widgets/primary_button.dart';
import '../../../domain/entities/wall.dart';

class WallInfoForm extends StatefulWidget {
  final String identifier;
  final Wall initialValue;
  final ValueChanged<Wall> onSaved;

  const WallInfoForm({
    Key? key,
    required this.identifier,
    required this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<WallInfoForm> createState() => _WallInfoFormState();
}

class _WallInfoFormState extends State<WallInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _widthController = TextEditingController();
  final _doorsQuantityController = TextEditingController();
  final _windowsQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _heightController.text = Formatter.simpleNumber(widget.initialValue.height);
    _widthController.text = Formatter.simpleNumber(widget.initialValue.width);
    _doorsQuantityController.text = widget.initialValue.doorsQuantity.toString();
    _windowsQuantityController.text = widget.initialValue.windowsQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Editar ${widget.identifier}',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: kMediumSpace),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Altura',
              hintText: 'Ex.: 3',
              prefixIcon: Icon(Icons.height_outlined),
            ),
            controller: _heightController,
            validator: Validator.decimalNumber(positive: true),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: kSmallSpace),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Largura',
              hintText: 'Ex.: 5',
              prefixIcon: Transform.rotate(angle: pi / 2, child: const Icon(Icons.height_outlined)),
            ),
            controller: _widthController,
            validator: Validator.decimalNumber(positive: true),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: kSmallSpace),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Portas',
              hintText: 'Ex.: 1',
              prefixIcon: Icon(Icons.door_back_door_outlined),
            ),
            controller: _doorsQuantityController,
            validator: Validator.integerNumber(positive: true),
            keyboardType: const TextInputType.numberWithOptions(),
          ),
          const SizedBox(height: kSmallSpace),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Janelas',
              hintText: 'Ex.: 2',
              prefixIcon: Icon(Icons.window_outlined),
            ),
            controller: _windowsQuantityController,
            validator: Validator.integerNumber(positive: true),
            keyboardType: const TextInputType.numberWithOptions(),
          ),
          const SizedBox(height: kMediumSpace),
          PrimaryButton(
            label: const Text('Salvar'),
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final newWall = Wall(
        height: Parser.decimalNumber(_heightController.text)!,
        width: Parser.decimalNumber(_widthController.text)!,
        doorsQuantity: Parser.integerNumber(_doorsQuantityController.text)!,
        windowsQuantity: Parser.integerNumber(_windowsQuantityController.text)!,
      );
      widget.onSaved(newWall);
    }
  }
}
