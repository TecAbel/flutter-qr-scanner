import 'package:flutter/foundation.dart';
import 'package:qr_scanner/models/qr_model.dart';
import 'package:qr_scanner/services/db_service.dart';

class ScanListService extends ChangeNotifier {
  List<QrModel> scansList = [];
  String typeSelected = ScanType.url;
  bool isLoading = false;

  void _toggleLoading(bool? value) {
    if (value != null) {
      isLoading = value;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
      return;
    }

    isLoading = !isLoading;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  Future<QrModel> addNewScan(String value) async {
    _toggleLoading(true);
    final scan = QrModel(value: value);
    final res = await DbService.db.newScan(scan);

    if (scan.type == typeSelected) {
      scan.id = res;
      scansList.add(scan);
    }
    _toggleLoading(false);
    return scan;
  }

  Future<void> loadAllScans() async {
    _toggleLoading(true);
    final scans = await DbService.db.getAllScans();
    scansList = scans;
    _toggleLoading(false);
  }

  Future<void> loadScansByType(String type) async {
    _toggleLoading(true);
    typeSelected = type;
    final scans = await DbService.db.getScansByType(type);
    scansList = scans;
    _toggleLoading(false);
  }

  Future<void> deleteAllScans() async {
    _toggleLoading(true);
    await DbService.db.deleteAllScans();
    scansList.clear();
    _toggleLoading(false);
  }

  Future<void> deleteScanById(int id) async {
    _toggleLoading(true);
    await DbService.db.deleteScan(id);
    scansList.removeWhere((x) => x.id == id);
    _toggleLoading(false);
  }
}
