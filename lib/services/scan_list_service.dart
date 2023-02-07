import 'package:flutter/foundation.dart';
import 'package:qr_scanner/models/qr_model.dart';
import 'package:qr_scanner/services/db_service.dart';

class ScanListService extends ChangeNotifier {
  List<QrModel> scansList = [];
  String typeSelected = ScanType.url;

  Future<void> addNewScan(String value) async {
    final scan = QrModel(value: value);
    final res = await DbService.db.newScan(scan);

    if (scan.type == typeSelected) {
      scan.id = res;
      scansList.add(scan);
      notifyListeners();
    }
  }

  Future<void> loadAllScans() async {
    final scans = await DbService.db.getAllScans();
    scansList = scans;
    notifyListeners();
  }

  Future<void> loadScansByType(String type) async {
    typeSelected = type;
    final scans = await DbService.db.getScansByType(type);
    scansList = scans;
    notifyListeners();
  }

  Future<void> deleteAllScans() async {
    await DbService.db.deleteAllScans();
    scansList.clear();
    notifyListeners();
  }

  Future<void> deleteScanById(int id) async {
    await DbService.db.deleteScan(id);
    scansList.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}
