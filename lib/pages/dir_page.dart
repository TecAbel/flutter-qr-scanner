import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanListView(
      emptyMessage: 'Aún no hay direcciones web registradas',
      itemIcon: Icons.web_rounded,
    );
  }
}
