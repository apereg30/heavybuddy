import 'package:flutter/material.dart';

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
      child: MaterialApp(
        title: 'Heavy Buddy',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        initialRoute: Routes.inicio,
        routes: Routes.table,
      ),
    );
  }
}
