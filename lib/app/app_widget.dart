import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'core/presenter/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Paint Calculator',
      theme: AppTheme.lightTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
