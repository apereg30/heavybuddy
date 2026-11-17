import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HeavyBuddyApp());
}

class HeavyBuddyApp extends StatelessWidget {
  const HeavyBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heavy Buddy',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: Routes.inicio,
      routes: Routes.table,
    );
  }
}
