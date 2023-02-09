import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/qr_model.dart';
import 'package:qr_scanner/services/db_service.dart';
import 'package:qr_scanner/services/scan_list_service.dart';
import 'package:qr_scanner/services/ui_service.dart';
import 'package:qr_scanner/utils/url_launc.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scanService = Provider.of<ScanListService>(context, listen: false);
    final uiService = Provider.of<UiService>(context, listen: false);
    void callLaunch(QrModel qr) => launchScan(context, qr);

    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3d8bef',
          'Cancelar',
          false,
          ScanMode.QR,
        );
        final scan = await scanService.addNewScan(barcodeScanRes);
        uiService.selected = scan.type == ScanType.url ? 1 : 0;
        callLaunch(scan);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
