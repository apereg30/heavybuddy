import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HeavyBuddyApp());
}

class HeavyBuddyApp extends StatefulWidget {
  const HeavyBuddyApp({super.key});

  @override
  State<HeavyBuddyApp> createState() => _HeavyBuddyAppState();
}

class _HeavyBuddyAppState extends State<HeavyBuddyApp> {
  final _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) => MaterialApp(
          title: 'Heavy Buddy',
          debugShowCheckedModeBanner: false,
          locale: const Locale('es'),
          supportedLocales: const [Locale('es')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: buildAppTheme(altoContraste: _state.altoContraste),
          builder: (context, child) {
            // Multiplica la escala del sistema, sin pisarla.
            final mq = MediaQuery.of(context);
            final factor = _state.textoGrande ? 1.3 : 1.0;
            return MediaQuery(
              data: mq.copyWith(textScaler: TextScaler.linear(mq.textScaler.scale(1) * factor)),
              child: child!,
            );
          },
          initialRoute: Routes.inicio,
          routes: Routes.table,
        ),
      ),
    );
  }
}
