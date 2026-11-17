import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'bottom_nav.dart';

/// Estructura común de pantalla: cabecera con "Volver", contenido
/// desplazable, acción inferior fija y barra de navegación opcional.
class HbScaffold extends StatelessWidget {
  const HbScaffold({
    super.key,
    required this.title,
    required this.children,
    this.bottomAction,
    this.navIndex,
    this.showBack = true,
  });

  final String title;
  final List<Widget> children;
  final Widget? bottomAction;
  final int? navIndex;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: showBack ? 104 : 0,
        titleSpacing: showBack ? 0 : AppSpacing.m,
        leading: showBack
            ? Padding(
                padding: const EdgeInsets.only(left: AppSpacing.m),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    child: const Text('Volver'),
                  ),
                ),
              )
            : null,
        title: Text(title),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.m),
                children: children,
              ),
            ),
            if (bottomAction != null) ...[
              Container(
                color: AppColors.tint,
                padding: const EdgeInsets.all(AppSpacing.m),
                child: SizedBox(width: double.infinity, child: bottomAction),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: navIndex == null ? null : HbBottomNav(current: navIndex!),
    );
  }
}
