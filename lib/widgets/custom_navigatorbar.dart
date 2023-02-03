import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/services/ui_service.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UiService uiService = Provider.of<UiService>(context);
    return BottomNavigationBar(
      onTap: (opt) {
        uiService.selected = opt;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapas',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
      ],
      currentIndex: uiService.selected,
    );
  }
}
