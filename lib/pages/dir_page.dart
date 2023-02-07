import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../services/scan_list_service.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scansService = Provider.of<ScanListService>(context);
    final scans = scansService.scansList;
    return scans.isEmpty
        ? const Center(
            child: Text('Aún no hay direcciones web registradas'),
          )
        : ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(
                Icons.web,
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
