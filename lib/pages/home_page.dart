import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/dir_page.dart';
import 'package:qr_scanner/pages/maps_page.dart';
import 'package:qr_scanner/services/ui_service.dart';
import 'package:qr_scanner/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
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

    switch (uiService.selected) {
      case 0:
        return const MapasPage();
      case 1:
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
