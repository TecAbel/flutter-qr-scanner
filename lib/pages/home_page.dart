import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/dir_page.dart';
import 'package:qr_scanner/pages/maps_page.dart';
import 'package:qr_scanner/services/db_service.dart';
import 'package:qr_scanner/services/scan_list_service.dart';
import 'package:qr_scanner/services/ui_service.dart';
import 'package:qr_scanner/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanService = Provider.of<ScanListService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => scanService.deleteAllScans(),
          ),
        ],
      ),
      body: const _HomeBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiService = Provider.of<UiService>(context);
    final scanListService =
        Provider.of<ScanListService>(context, listen: false);

    switch (uiService.selected) {
      case 0:
        scanListService.loadScansByType(ScanType.geo);
        return const MapasPage();
      case 1:
        scanListService.loadScansByType(ScanType.url);
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
