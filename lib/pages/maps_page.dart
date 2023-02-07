import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/config/app_theme.dart';

import '../services/scan_list_service.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scansService = Provider.of<ScanListService>(context);
    final scans = scansService.scansList;
    return scans.isEmpty
        ? const Center(
            child: Text('Aún no hay geolocalizaiciones registradas'),
          )
        : ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(
                Icons.home,
                color: CustomAppTheme.primaryColor,
              ),
              title: Text(scans[index].value),
              subtitle: Text(
                'ID: ${scansService.scansList[index].id}',
                style: const TextStyle(fontSize: 10),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => print('ontap on $index'),
            ),
          );
  }
}
