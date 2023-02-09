import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/config/app_theme.dart';
import 'package:qr_scanner/services/scan_list_service.dart';

class ScanListView extends StatelessWidget {
  const ScanListView({
    super.key,
    required this.itemIcon,
    required this.emptyMessage,
  });

  final IconData itemIcon;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final scansService = Provider.of<ScanListService>(context);
    final scans = scansService.scansList;
    return scans.isEmpty
        ? Center(
            child: Text(emptyMessage),
          )
        : ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.redAccent,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                scansService.deleteScanById(scans[index].id!);
              },
              child: ListTile(
                leading: Icon(
                  itemIcon,
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
            ),
          );
  }
}
